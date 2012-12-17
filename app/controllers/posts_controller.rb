class PostsController < ApplicationController

  def create
    
    board_id = params[:post].delete(:board_id)

    @post = Post.new(params[:post])
    @post.board_id = board_id
    @post.user_id = current_user.id

    @post.save
    
    redirect_to board_path(@post.board)
  end

  def show
  	@post = Post.find(params[:id])
    @board = Board.find(@post.board_id)
  	
    @comment = Comment.new
    @comment.post_id = @post.id
  end

  def vote_up
    begin
      current_user.vote_for(@post = Post.find(params[:id]))
      redirect_to :back
      flash[:sucess] = "You have voted successfully"
      #render :nothing => true, :status => 200
    rescue ActiveRecord::RecordInvalid
      #render :nothing => true, :status => 404
      redirect_to :back
      flash[:error] = "You have already voted for this one"
    end
  end


end
