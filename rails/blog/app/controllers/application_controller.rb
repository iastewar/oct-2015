class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user
    unless user_signed_in?
      redirect_to new_session_path, alert: "Please sign in!"
    end
  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id] if session[:user_id]
  end
  helper_method :current_user # lets us use this method in views and controllers

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def email_comment_summary
    all_comments_today = Comment.where("created_at >= ?", 1.day.ago)
    CommentsMailer.comment_summary(all_comments_today, User.all).deliver_later
  end
  helper_method :email_comment_summary
end
