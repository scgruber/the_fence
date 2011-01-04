class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    if user_signed_in?
      redirect_to(root_path)
    else
      authenticate_user!
    end
  end
end
