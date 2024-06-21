class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase_shippingaddress = PurchaseShippingaddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_shippingaddress = PurchaseShippingaddress.new(shippingaddress_params)
    @purchase_shippingaddress.user_id = current_user.id
    
    if @purchase_shippingaddress.save
      redirect_to item_path(params[:item_id])
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def shippingaddress_params
    params.require(:purchase_shippingaddress).permit(:postalcode, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
