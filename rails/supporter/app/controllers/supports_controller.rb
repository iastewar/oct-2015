class SupportsController < ApplicationController
  before_action :find_support, only: [:show, :edit, :update, :destroy]

  def new
    @s = Support.new
  end

  def create
    @s = Support.new(support_params)
    if @s.save
      redirect_to(support_path(@s), notice: "Support created!")
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @s.update support_params
      redirect_to(support_path(@s))
    else
      render :edit
    end
  end

  def index
    #@supports = Support.all
    #@supports = Support.page(1).per(2)
    @supports = Support.page params[:page]
  end

  def destroy
    @s.destroy
    flash[:notice] = "Support deleted successfully"
    redirect_to supports_path
  end

  def search
    @search_string = params[:search][:search]
    @supports_name_length = Support.where("name ILIKE ?", "%#{@search_string}%").length
    @supports_email_length = Support.where("email ILIKE ?", "%#{@search_string}%").length
    @supports_message_length = Support.where("message ILIKE ?", "%#{@search_string}%").length

    @supports = Support.where("name ILIKE ? OR email ILIKE ? OR message ILIKE ?", "%#{@search_string}%", "%#{@search_string}%", "%#{@search_string}%").page params[:page]
    @supports_name = @supports.where("name ILIKE ?", "%#{@search_string}%")
    @supports_email = @supports.where("email ILIKE ?", "%#{@search_string}%")
    @supports_message = @supports.where("message ILIKE ?", "%#{@search_string}%")
  end

  private

  def support_params
    params.require(:support).permit([:name, :email, :department, :message, :done])
  end

  def find_support
    @s = Support.find(params[:id])
  end

end
