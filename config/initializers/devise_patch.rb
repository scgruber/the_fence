# TODO: file bug
module Devise
  class FailureApp
    def redirect
      store_location!
      # flash[:alert] = i18n_message unless flash[:notice]
      flash[:alert] = i18n_message unless (flash[:notice] || flash[:alert])
      redirect_to send(:"new_#{scope}_session_path")
    end
  end
end