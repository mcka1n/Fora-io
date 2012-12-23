class Follow < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:user_id, :board_id]
end
