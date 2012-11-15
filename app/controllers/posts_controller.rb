class PostsController < ApplicationController

  def create
    board_id = params[:post].delete(:board_id)

    @post = Post.new(params[:post])
    @post.board_id = board_id
    @post.user_id = current_user.id

    @post.save

    redirect_to board_path(@post.board)
  end


end
