class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate
  before_filter :sidebar

  def authenticate
    http_basic_authenticate_with :name => "fora", :password => "gobeta4", :except => :index
  end

  def sidebar
  	@boardsList = Board.all
  end

end
