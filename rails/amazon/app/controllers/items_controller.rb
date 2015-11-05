class ItemsController < ApplicationController
  before_action :authenticate_user, except: :show

  def new
    @i = Item.new
  end

  def create
    item_params = params.require(:item).permit([:title, :price, :description])
    @i = Item.new(item_params)
    @item.user = current_user
    if @i.save
      redirect_to(item_path(@i))
    else
      render :new
    end
  end

  def show
    @i = Item.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where item: @i
  end


end
