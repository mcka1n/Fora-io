class RepliesController < ApplicationController

 def create
  #raise params.inspect
  comment_id = params[:reply].delete(:comment_id)

  @reply = Reply.new(params[:reply])
  @reply.user_id = current_user.id
  @reply.comment_id = comment_id
  #check about parent_reply_id (it should be 0 if it's not a reply from a reply.)
  @reply.parent_reply_id = 0
  @reply.save


  @comment = Comment.find(comment_id)
  redirect_to post_path(@comment.post)
 end


 def show
  @reply = Reply.find(params[:id])  	
 end

end
