class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate
  before_filter :sidebar

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      # Change these to username and password required
      user_name == "fora" && password == "gobeta"
    end
  end

  def sidebar
  	@boardsList = Board.all
  end

end
