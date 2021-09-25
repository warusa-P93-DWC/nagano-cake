class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    @genre = Genre.all
    @items = Item.page(params[:page]).per(10)

  end

  def create
    @item = Item.new(admin_item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end


  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genre = Genre.all

  end

  def index
    @items = Item.all

  end

  def update
    @item = Item.find(params[:id])
    @item.update(admin_item_params)
    redirect_to admin_item_path(@item)

  end

  private

  def admin_item_params
    params.require(:item).permit(:name, :image, :detail, :genre_id, :price, :is_active)
  end
end
