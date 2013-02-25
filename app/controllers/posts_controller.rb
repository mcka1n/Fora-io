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
    # ----
    # These are model (Board) functions. 
    @is_following_up = @board.is_following_up(@post.board_id, current_user.id)
    @board_members = @board.board_member_amount(@post.board_id)
  	# ----
    @comment = Comment.new
    @comment.post_id = @post.id
    # ----
    @reply = Reply.new
    # ----
    @stars_for = Star.find(:all, :conditions => { :post_id => params[:id], :status => 1 }).count
    # ----
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



  def star
    @post = Post.find(params[:id])
    @found = Star.find(:all, :conditions => { :user_id => current_user.id, :post_id => params[:id] })
    if @found.any?
      if @found[0].status == 0
        #update star status to 1
        @found[0].status = 1
        @found[0].save
        flash[:message] = "Nice! You starred '#{@post.title}' again !"
      else
        flash[:message] = "You already starred '#{@post.title}'  !"
      end  
      redirect_to post_path(@post)
    else
      #create a new star
      @star = Star.new
      @star.user_id = current_user.id
      @star.post_id = params[:id]
      @star.status = 1
      @star.save
      flash[:message] = "Voila! You just starred '#{@post.title}' ;) !"
      redirect_to post_path(@post)
    end
  end


  def unstar
    #Star down 'will not' delete the 'follow', it will just change the status (from 1 to 0)
    @post = Post.find(params[:id])
    @found = Star.find(:all, :conditions => { :user_id => current_user.id, :post_id => params[:id] })
    if @found.any?
      @found[0].status = 0
      @found[0].save
      flash[:message] = "You just unstarred '#{@post.title}'  !"
      redirect_to post_path(@post)
    else
      flash[:message] = "Oops! You are have NOT starred '#{@post.title}' yet!"
      redirect_to post_path(@post)
    end
  end

  def is_star(params)
    @found = Star.find(:all, :conditions => { :user_id => current_user.id, :post_id => params, :status => 1 })
    if @found.any?
      true
    else
      false
    end
  end

  def stars_for(params)
    @found = Star.find(:all, :conditions => { :post_id => params, :status => 1 })
    if @found.any?
      @found.count
    else
      false
    end
  end

end
