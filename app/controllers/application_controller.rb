class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    unless logged_in? 
      store_location
      redirect_to login_path, flash: {danger: "Please log in."}
    end
  end
end
