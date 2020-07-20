# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  #before_action  :layconf

  # GET /resource/sign_in
   def new
     super
     #redirect_to :layout => "layout2"
     #render :layout => "layout_2"
     #redirect_to  "http://127.0.0.1:3000/pages/login"
      #redirect_to pages_login_path

    end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private
  def layconf
    #render :layout => "empty"
    redirect_to pages_login_path
  end
end
