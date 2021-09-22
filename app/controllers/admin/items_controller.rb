class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
    @item = Item.new(admin_item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end

  def edit
  end

  def show
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.all

  end

  def update
    
  end

  private

  def admin_item_params
    params.require(:item).permit(:name, :image, :detail, :genre_id, :price, :is_active)
  end
end
