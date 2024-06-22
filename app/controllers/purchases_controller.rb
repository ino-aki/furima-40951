class PurchasesController < ApplicationController
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @item = Item.find(params[:item_id])
    @purchase_shippingaddress = PurchaseShippingaddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_shippingaddress = PurchaseShippingaddress.new(shippingaddress_params)
    @purchase_shippingaddress.user_id = current_user.id
    
    if @purchase_shippingaddress.valid?
      pay_item
      @purchase_shippingaddress.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: shippingaddress_params[:token],
      currency: 'jpy'
    )
  end

  def shippingaddress_params
    params.require(:purchase_shippingaddress).permit(:postalcode, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
end
