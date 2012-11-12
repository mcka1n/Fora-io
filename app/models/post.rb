class Post < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :author_name, :body

  belongs_to :board
end
