class BoardsController < ApplicationController
 
 before_filter :authenticate_user!
 
 def index
  @boards = Board.all
 end

  def show
  	@board = Board.find(params[:id])

  	@post = Post.new
	  @post.board_id = @board.id

    @is_following_up = is_following_up(params[:id])
    @board_members = board_member_amount(params[:id])

    
  end

  def new
  	@board = Board.new

  end

  def create
  	@board = Board.new
    @board.user_id = current_user.id
  	@board.title = params[:board][:title]
  	@board.description = params[:board][:description]
  	@board.save

    # ------ Auto Follow 
    @follow = Follow.new
    @follow.user_id = current_user.id
    @follow.board_id = @board.id
    @follow.status = 1
    @follow.save

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

  def list
    @boardsList = Board.all
    
    render 'list'
  end

  def topic_info
    @topic = Board.find(params[:id])
  end

  def follow_up
    #raise params.inspect # We use it to debug what's coming from the form (view)
    @board = Board.find(params[:id])
    @found = Follow.find(:all, :conditions => { :user_id => current_user.id, :board_id => params[:id] })
    if @found.any?
      if @found[0].status == 0
        #update follow status to 1
        @found[0].status = 1
        @found[0].save
        flash[:message] = "Sweet! You are following '#{@board.title}' again !"
      else
        flash[:message] = "You are already following '#{@board.title}'  !"
      end  
      redirect_to board_path(@board)
    else
      #create a new follow
      @follow = Follow.new
      @follow.user_id = current_user.id
      @follow.board_id = params[:id]
      @follow.status = 1
      @follow.save
      flash[:message] = "Now you are following '#{@board.title}' ;) !"
      redirect_to board_path(@board)
    end
  end


  def follow_down
    #Follow down 'will not' delete the 'follow', it will just change the status (from 1 to 0)
    @board = Board.find(params[:id])
    @found = Follow.find(:all, :conditions => { :user_id => current_user.id, :board_id => params[:id] })
    if @found.any?
      @found[0].status = 0
      @found[0].save
      flash[:message] = "You just left '#{@board.title}'  !"
      redirect_to board_path(@board)
    else
      flash[:message] = "Oops! You are NOT following '#{@board.title}' !"
      redirect_to board_path(@board)
    end
  end

  def is_following_up(params)
    @found = Follow.find(:all, :conditions => { :user_id => current_user.id, :board_id => params, :status => 1 })
    if @found.any?
      true
    else
      false
    end
  end


  def board_member_amount(params)
    @found = Follow.where(:board_id => params, :status => 1).count
  end


  def trending
    #just for MySQL
    #@trending = Post.tally.where('board_id = ?', params[:id]).having('vote_count < 10')
    #For PostgreSQL
    @trending = Post.tally.where('board_id = ?', params[:id]).having('COUNT(votes.id) < 10')
    @board = Board.find(params[:id])
    @is_following_up = is_following_up(params[:id])
    @board_members = board_member_amount(params[:id])
    render 'trending'
  end


  def new_thread_list
    @thread = Post.find(:all, :conditions => {:board_id => params[:id]}, :order => "created_at DESC")
    
    @is_following_up = is_following_up(params[:id])
    @board_members = board_member_amount(params[:id])
    render 'new_thread_list'
  end
  
  def popular
    #postsboard1 = Post.find(:all, :select => 'id',:conditions => {:board_id => '1'}).map(&:id)
    #Comment.find(postsboard1)
    #Final one:
    postsOnBoard = Post.find(:all, :select => 'id',:conditions => {:board_id => params[:id]}).map(&:id)
    @commentAmountPerPost = Comment.count(:all,:conditions => ['post_id in (?)', postsOnBoard], :group => 'post_id', :order => 'count_all DESC')
    mostCommentedPosts = Comment.find(
    :all, 
    :select => 'count(*) count, post_id', 
    :group => 'post_id', 
    :conditions => ['post_id in (?)', postsOnBoard], 
    :order => 'count DESC').map(&:post_id)
    @popular = Post.find(:all,:conditions => ['id in (?)', mostCommentedPosts], :order => 'created_at')

    
    @board = Board.find(params[:id])
    @is_following_up = is_following_up(params[:id])
    @board_members = board_member_amount(params[:id])
    render 'popular'
  end


end
