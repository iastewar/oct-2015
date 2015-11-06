class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @p = Post.new
  end

  def create
    @p = Post.new(post_params)
    if @p.save
      redirect_to(post_path(@p), notice: "Post created!")
    else
      render :new
    end
  end

  def show
    @comments = @p.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @p.update post_params
      redirect_to(post_path(@p))
    else
      render :edit
    end
  end

  def index
    @posts = Post.all
  end

  def destroy
    @p.destroy
    flash[:notice] = "Post deleted successfully"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit([:title, :body])
  end

  def find_post
    @p = Post.find(params[:id])
  end
end
