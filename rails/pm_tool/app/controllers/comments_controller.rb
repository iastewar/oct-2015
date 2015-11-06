class CommentsController < ApplicationController
  before_action :find_project, only: [:create, :edit, :update]
  before_action :find_discussion, only: [:create, :edit, :update]
  before_action :find_comment, only: [:edit, :update, :destroy]


  def create
    @comment = Comment.new comment_params
    @comment.discussion = @discussion

    if @comment.save
      redirect_to project_discussion_path(@p, @discussion), notice: "Comment created succussfully!"
    else
      @comments = @discussion.comments.order(created_at: :desc)
      render "discussions/show"
    end
  end

  def destroy
    @comment.destroy
    redirect_to project_discussion_path(params[:project_id], params[:discussion_id]), notice: "Comment deleted"
  end

  def edit
    @comments = @discussion.comments.order(created_at: :desc)
    render "discussions/show"
  end

  def update
    if @comment.update comment_params
      redirect_to project_discussion_path(@p, @discussion)
    else
      @comments = @discussion.comments.order(created_at: :desc)
      render "discussions/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_project
    @p = Project.find params[:project_id]
  end

  def find_comment
    @comment = Comment.find params[:id]
  end

  def find_discussion
    @discussion = Discussion.find params[:discussion_id]
  end


end