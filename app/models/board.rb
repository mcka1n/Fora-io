class Board < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :posts

 def is_following_up(params, currentUser)
  @found = Follow.find(:all, :conditions => { :user_id => currentUser, :board_id => params, :status => 1 })
   if @found.any?
    true
   else
    false
   end
 end


 def board_member_amount(params)
  @found = Follow.where(:board_id => params, :status => 1).count
 end

end
