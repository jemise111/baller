class CommentsController < ApplicationController
  before_action :require_authentication
  before_action :require_admin_authentication, only: [:admin_index]

  def admin_index
    # For admin tools
    @approved_comments = Comment.where(approved: true)
    @unapproved_comments = Comment.where(approved: false)
  end

  # DRY up redirects
  def new
    @court = Court.find(params[:court_id])
    @comment = @court.comments.new
  end

  def create
    @comment = Court.find(params[:court_id]).comments.create(comment_params)
    @comment.update(approved: false, user_id: session[:user_id])
    redirect_to @comment.court
  end

  # as of now when a comment is approved and then edited, it goes back in for approval
  def edit
    @comment = Comment.find(params[:id])
    redirect_to @comment.court unless (current_admin || @comment.user == current_user)
  end

  def update
    redirect_to @comment.court unless (current_admin || @comment.user == current_user)
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    @comment.update(approved: false)
    redirect_to @comment.court
  end

  def destroy
    @comment = Comment.find(params[:id])
    court = @comment.court
    redirect_to @comment.court unless (current_admin || @comment.user == current_user)
    @comment.destroy
    redirect_to court
  end

  def approval
    comment = Comment.find(params[:id])
    comment.approved = !comment.approved
    comment.save
    redirect_to comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
