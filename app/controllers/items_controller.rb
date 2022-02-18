class ItemsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :category_id, :condition_id, :postage_id, :prefecture_id,
                                 :shipping_on_id).merge(user_id: current_user.id)
  end
end
