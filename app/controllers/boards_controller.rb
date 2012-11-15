class BoardsController < ApplicationController
 
 before_filter :authenticate_user!
 
 def index
  @boards = Board.all
 end

  def show
  	@board = Board.find(params[:id])

  	@post = Post.new
	@post.board_id = @board.id

  end

  def new
  	@board = Board.new

  end

  def create
	#raise params.inspect	# We use it to debug what's coming from the form (view)
  	@board = Board.new
    @board.user_id = current_user.id
  	@board.title = params[:board][:title]
  	@board.description = params[:board][:description]
  	@board.save
    flash[:message] = "Board '#{@board.title}' created!"
  	redirect_to board_path(@board)
  end


  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    flash[:message] = "Board '#{@board.title}' has been destroyed!"
    redirect_to boards_path
  end

  def edit
    @board = Board.find(params[:id])
  end


  def update
  #raise params.inspect # We use it to debug what's coming from the form (view)
    @board = Board.find(params[:id])
    @board.title = params[:board][:title]
    @board.description = params[:board][:description]
    @board.save
    flash[:message] = "Board '#{@board.title}' Updated!"
    redirect_to board_path(@board)
  end 

end
