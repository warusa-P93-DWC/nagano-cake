class Public::ItemsController < ApplicationController
  def index
     @items = Item.all
  end

  def show
  end

  def edit
    @item = Item.find(params[:id])
  end
end
