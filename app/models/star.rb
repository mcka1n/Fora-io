class Star < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :user_id, :scope => [:user_id, :post_id]
end
