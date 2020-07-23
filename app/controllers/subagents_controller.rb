class SubagentsController < ApplicationController
  before_action :set_subagent, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /subagents
  # GET /subagents.json
  def index
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagents = Subagent.all.where(agent_id: params["agent_id"])
    @position = Shop.joins(subagent: [agent:[:masteragent]]).where(masteragents: {id: params["masteragent_id"]})
    @hash = Gmaps4rails.build_markers(@position) do |position, marker|
      marker.lat  position.lat
      marker.lng  position.lng
      marker.title position.name
      marker.infowindow render_to_string(:partial => "info",
              :locals => {:name => position.name, :lat => position.lat, :lng => position.lng })

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
end
