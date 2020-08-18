class StructacessController < ApplicationController
  def new
  end
  def createauth
    puts "***************************"
    puts  params
    puts "***************************"
    @user = User.new(:email => params["email"], :password => params["password"], :password_confirmation => params["password_confirmation"])
    @user["role_id"] = 4
    @user["struct_id"] = params["id"]
    respond_to do |format|
      if @user.save
        format.html { redirect_to masteragent_agent_subagents_path, notice: 'Credentials was successfully created.' }
        format.json { render :show, status: :created, location: @subagent }
      else
        format.html { render :newauth }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
