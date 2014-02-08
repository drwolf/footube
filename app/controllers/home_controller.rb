class HomeController < ApplicationController

  def index
    @videos = Video.limit(6).page(params[:page] || 1)
  end

end
