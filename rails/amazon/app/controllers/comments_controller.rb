class CommentsController < ApplicationController
  def create
    comment_params = params.require(:comment).permit(:body)
    @i = Item.find params[:item_id]
    @comment = Comment.new comment_params
    @comment.item = @i
    
    if @comment.save
      redirect_to item_path(@i), notice: "comment created successfully"
    else
      render "items/show"
    end

  end
end
