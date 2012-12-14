class CommentsController < ApplicationController

  def create
    #raise params.inspect
    post_id = params[:comment].delete(:post_id)

    @comment = Comment.new(params[:comment])
    @comment.post_id = post_id
    @comment.user_id = current_user.id

    @comment.save

    redirect_to post_path(@comment.post)
  end




  def show
  	@comment = Comment.find(params[:id])
  	
  end

end
