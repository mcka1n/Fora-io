class Post < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_voteable
  attr_accessible :author_name, :body

  belongs_to :board
  has_many :comments
end
