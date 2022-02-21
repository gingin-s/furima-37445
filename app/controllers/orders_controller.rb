class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index_if_sold_out
  before_action :set_item, only: [:index, :create]
  def index
    @order_info = OrderInfo.new
  end

  def create
    @order_info = OrderInfo.new(order_params)
    if @order_info.valid?
      pay_item
      @order_info.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def move_to_index_if_sold_out
    item = Item.find(params[:item_id])
    redirect_to root_path if item.order || current_user.id == item.user_id
  end

  def order_params
    params.require(:order_info).permit(:post_code, :city, :address, :building_name, :phone_number, :prefecture_id).merge(
      item_id: params[:item_id], user_id: current_user.id, token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  # カード決済処理
  def pay_item
    item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
