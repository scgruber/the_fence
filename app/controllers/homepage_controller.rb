class HomepageController < ApplicationController
  respond_to :html

  def index
    @featured = Event.featured
    respond_with(@featured)
  end

end
