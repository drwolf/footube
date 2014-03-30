class HomeController < ApplicationController

  def index
    @videos = Video.published.limit(6)
  end

end
