class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery unless: -> { request.format }
  def after_sign_in_path_for(resource)
    current_user.landing_link
  end
  def redirect_usr
    if (access_managment == "ok" )
      puts "****start***********************"
      puts  "ACCESS GRANTED"
      puts "****end***********************"
    else
      puts "****start***********************"
      puts  "RESTRICTED AREA REDIRECTED"
      puts "****end***********************"
      redirect_to current_user.landing_link #pages_lockscreen_path
    end
  end

end
