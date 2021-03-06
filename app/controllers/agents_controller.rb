class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :redirect_usr

  # GET /agents
  # GET /agents.json
  def createauth
    @user = User.new(:email => params["email"], :password => params["password"], :password_confirmation => params["password_confirmation"])
    @user["role_id"] = 3
    @user["struct_id"] = params["stid"]
    @user["landing_link"] = masteragent_agent_subagents_path(params["masteragent_id"],params["stid"])
    respond_to do |format|
      if @user.save
        @agent = Agent.find(params["stid"])
        @agent.account = true
        @agent.save
        format.html { redirect_to @user["landing_link"], notice: 'Credentials was successfully created.' }
        format.json { render :show, status: :created, location: @subagent }
      else
        format.html { redirect_to masteragent_agents_path}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    params[:id] = 22
    @user = User.new
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agents = Agent.all.where(masteragent_id: params["masteragent_id"])
    @position = Shop.joins(subagent: [agent:[:masteragent]]).where(masteragents: {id: params["masteragent_id"]}).where.not(lat: nil)
    @hash = Gmaps4rails.build_markers(@position) do |position, marker|
      marker.lat  position.lat
      marker.lng  position.lng
      marker.title position.name
      marker.infowindow render_to_string(:partial => "info",
              :locals => {:name => position.name, :lat => position.lat, :lng => position.lng })

    end
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
  end

  # GET /agents/new
  def new
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.build
  end

  # GET /agents/1/edit
  def edit
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["id"])
  end

  # POST /agents
  # POST /agents.json
  def create
    #@agent = Agent.new(agent_params)
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.build(agent_params)
    respond_to do |format|
      if @agent.save
        format.html { redirect_to masteragent_agent_path: @agent, notice: 'Agent was successfully created.' }
        format.json { render :show, status: :created, location: @agent }
      else
        format.html { render :new }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agents/1
  # PATCH/PUT /agents/1.json
  def update
    respond_to do |format|
      if @agent.update(agent_params)
        format.html { redirect_to masteragent_agent_path: @agent, notice: 'Agent was successfully updated.' }
        format.json { render :show, status: :ok, location: @agent }
      else
        format.html { render :edit }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    @agent.destroy
    respond_to do |format|
      format.html { redirect_to agents_url, notice: 'Agent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def agent_params
      #params.fetch(:agent, {})
      params.require(:agent).permit(:name, :masteragent_id)
    end
    def access_managment
      case current_user.role.name
      when "subagent"
        @result = "nok"

      when "agent"
        @result = "nok"

      when "master"
        if current_user.struct_id == params["masteragent_id"].to_i
          @result = "ok"
        end

      when "admin"
        @result = "ok"

      else
        @result = "nok"
      end
    end


end
