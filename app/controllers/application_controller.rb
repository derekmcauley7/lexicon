class ApplicationController < ActionController::Base
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(root_path)
    end
  end
end
