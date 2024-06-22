class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    if @item.user == current_user || @item.purchase.present?
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      @purchase_shippingaddress = PurchaseShippingaddress.new
    end
  end

  def create
    @purchase_shippingaddress = PurchaseShippingaddress.new(shippingaddress_params)
    @purchase_shippingaddress.user_id = current_user.id

    if @purchase_shippingaddress.valid?
      pay_item
      @purchase_shippingaddress.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: shippingaddress_params[:token],
      currency: 'jpy'
    )
  end

  def shippingaddress_params
    params.require(:purchase_shippingaddress).permit(:postalcode, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end
end
