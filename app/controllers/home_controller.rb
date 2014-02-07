class HomeController < ApplicationController

  def index
    @videos = Video.page(params[:page] || 1)
  end

end
