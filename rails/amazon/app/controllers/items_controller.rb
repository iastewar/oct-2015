class ItemsController < ApplicationController
  def new
    @i = Item.new
  end

  def create
    item_params = params.require(:item).permit([:title, :price, :description])
    @i = Item.new(item_params)

    if @i.save
      redirect_to(item_path(@i))
    else
      render :new
    end
  end

  def show
    @i = Item.find(params[:id])
  end


end
