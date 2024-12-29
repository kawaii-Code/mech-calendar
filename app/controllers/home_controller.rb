class HomeController < ApplicationController
  include Authentication

  def index
  end
  def calendar
    @current_user = User.current
  end
end
