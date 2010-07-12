class HomepageController < ApplicationController
  respond_to :html

  def index
    @featured = Event.featured.desc(:page_rank).all
    respond_with(@featured)
  end

end
