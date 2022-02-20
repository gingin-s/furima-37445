class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_info = OrderInfo.new
  end
  
  def create
    @order_info = OrderInfo.new(order_params)
    # binding.pry
    if @order_info.valid?
      @order_info.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private
  def order_params
    params.require(:order_info).permit(:post_code, :city, :address, :building_name, :phone_number, :prefecture_id).merge(item_id: params[:item_id], user_id: current_user.id)
  end
end
