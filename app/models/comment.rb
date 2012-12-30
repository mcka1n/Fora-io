class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :body
  belongs_to :post
  has_many :replies
end
