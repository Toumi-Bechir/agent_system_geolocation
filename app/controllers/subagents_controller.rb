class SubagentsController < ApplicationController
  before_action :set_subagent, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  #before_action :redirect_usr

  # GET /subagents
  # GET /subagents.json
  def newauth
    puts "***************************"
    puts  params
    puts "***************************"
    @user = User.new
    #redirect_to controller: 'users/registrations', action: 'new'
  end

  def createauth
    @user = User.new(:email => params["email"], :password => params["password"], :password_confirmation => params["password_confirmation"])
    @user["role_id"] = 4
    @user["struct_id"] = params["stid"]
    @user["landing_link"] = masteragent_agent_subagent_shops_path(params["masteragent_id"],params["agent_id"],params["stid"])

    puts "***************************"
    puts  masteragent_agent_subagent_shops_path(params["masteragent_id"],params["agent_id"],params["id"])
    puts "***************************"
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user["landing_link"], notice: 'Credentials was successfully created.' } #masteragent_agent_subagents_path
        format.json { render :show, status: :created, location: @subagent }
      else
        format.html { render :newauth }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    params[:id] = 22
    @user = User.new
    puts "***************************"
    puts  request.path
    puts "***************************"
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagents = Subagent.all.where(agent_id: params["agent_id"])
    @position = Shop.joins(subagent: [agent:[:masteragent]]).where(masteragents: {id: params["masteragent_id"]})
    @hash = Gmaps4rails.build_markers(@position) do |position, marker|
      marker.lat  position.lat
      marker.lng  position.lng
      marker.title position.name
      marker.infowindow render_to_string(:partial => "info",
              :locals => {:name => position.name, :lat => position.lat, :lng => position.lng, :id => 22})

    end
  end

  # GET /subagents/1
  # GET /subagents/1.json
  def show
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagents = Subagent.find(params["id"])
  end

  # GET /subagents/new
  def new
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagent = @agent.subagents.build  #Subagent.new
  end

  # GET /subagents/1/edit
  def edit
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagents = Subagent.find(params["id"])
  end

  # POST /subagents
  # POST /subagents.json
  def create
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagent = @agent.subagents.build(subagent_params)
    #@subagent = Subagent.new(subagent_params)

    respond_to do |format|
      if @subagent.save
        format.html { redirect_to masteragent_agent_subagents_path, notice: 'Subagent was successfully created.' }
        format.json { render :show, status: :created, location: @subagent }
      else
        format.html { render :new }
        format.json { render json: @subagent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subagents/1
  # PATCH/PUT /subagents/1.json
  def update
    respond_to do |format|
      if @subagent.update(subagent_params)
        format.html { redirect_to masteragent_agent_subagent_path(params["masteragent_id"],params["agent_id"],params["id"]), notice: 'Subagent was successfully updated.' }
        format.json { render :show, status: :ok, location: @subagent }
      else
        format.html { render :edit }
        format.json { render json: @subagent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subagents/1
  # DELETE /subagents/1.json
  def destroy
    @subagent.destroy
    respond_to do |format|
      format.html { redirect_to subagents_url, notice: 'Subagent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subagent
      @subagent = Subagent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subagent_params
      #params.fetch(:subagent, {})
      params.require(:subagent).permit(:name, :agent_id, :masteragent_id)
    end
    def user_params
      params.require(:user).permit(:email, :password, :id)
      #devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :role_id, :struct_id])
    end
    def access_managment
      case current_user.role.name
      when "subagent"
        @result = "ok"

      else
        @result = "nok"
      end
    end
    def redirect_usr
      if (access_managment == "ok" )
        puts "***************************"
        puts  current_user.role.name
        puts "***************************"
        redirect_to pages_lockscreen_path
      end
    end
end
