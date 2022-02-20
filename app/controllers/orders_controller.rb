class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index_if_sold_out
  def index
    @item = Item.find(params[:item_id])
    @order_info = OrderInfo.new
  end
  
  def create
    @order_info = OrderInfo.new(order_params)
    if @order_info.valid?
      pay_item
      @order_info.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def move_to_index_if_sold_out
    item = Item.find(params[:item_id])
    if item.order || current_user.id == item.user_id
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order_info).permit(:post_code, :city, :address, :building_name, :phone_number, :prefecture_id).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  # カード決済処理
  def pay_item
    item = Item.find(params[:item_id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
