class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      flash[:alert] = "You don't have permission to do that." # TODO make customizable based on violation
      redirect_to(root_path)
    else
      authenticate_user!
    end
  end
end
