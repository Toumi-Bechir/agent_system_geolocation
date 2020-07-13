class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # GET /agents
  # GET /agents.json
  def index
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agents = Agent.all.where(masteragent_id: params["masteragent_id"])
    @position = Shop.joins(subagent: [agent:[:masteragent]]).where(masteragents: {id: params["masteragent_id"]})
    @hash = Gmaps4rails.build_markers(@position) do |position, marker|
      marker.lat  position.lat
      marker.lng  position.lng
      marker.title position.name
      marker.infowindow render_to_string(:partial => "info",
              :locals => {:name => position.name })

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
end
