class Reply < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :body
  belongs_to :comment
end
