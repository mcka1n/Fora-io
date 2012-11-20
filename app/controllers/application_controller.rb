class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :sidebar
  def sidebar
  	@boardsList = Board.all
  end
end
