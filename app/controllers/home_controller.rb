class HomeController < ApplicationController
  def index
  end
  def calendar
    @current_user = User.current
  end
end
