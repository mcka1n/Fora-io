class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate
  before_filter :sidebar

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "craigslistkiller"
    end
  end

  def sidebar
  	@boardsList = Board.all
  end

end
