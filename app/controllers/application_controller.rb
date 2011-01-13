class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    if user_signed_in?
      redirect_to(root_path)
    else
      redirect_to(new_user_session_path)
    end
  end
end
