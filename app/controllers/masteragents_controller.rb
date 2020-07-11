class MasteragentsController < ApplicationController
  before_action :set_masteragent, only: [:show, :edit, :update, :destroy]

  # GET /masteragents
  # GET /masteragents.json
  def index
    @position = []
    @pcount = 0
    @masteragents = Masteragent.all
    @masteragents.each do |master|
      master.agents.each do |agent|
        agent.subagents.each do |subagent|
          subagent.shops.each do |shop|
            @position[@pcount]= shop
            @pcount+=1
          end
        end
      end
    end
    @hash = Gmaps4rails.build_markers(@position) do |position, marker|
      marker.lat  position.lat
      marker.lng  position.lng
      marker.title position.name
      #marker.json({ name: position.name })
      marker.infowindow render_to_string(:partial => "info",
              :locals => {:name => position.name })

    end
  end

  # GET /masteragents/1
  # GET /masteragents/1.json
  def show
  end

  # GET /masteragents/new
  def new
    @masteragent = Masteragent.new
  end

  # GET /masteragents/1/edit
  def edit
  end

  # POST /masteragents
  # POST /masteragents.json
  def create
    @masteragent = Masteragent.new(masteragent_params)

    respond_to do |format|
      if @masteragent.save
        format.html { redirect_to @masteragent, notice: 'Masteragent was successfully created.' }
        format.json { render :show, status: :created, location: @masteragent }
      else
        format.html { render :new }
        format.json { render json: @masteragent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /masteragents/1
  # PATCH/PUT /masteragents/1.json
  def update
    respond_to do |format|
      if @masteragent.update(masteragent_params)
        format.html { redirect_to @masteragent, notice: 'Masteragent was successfully updated.' }
        format.json { render :show, status: :ok, location: @masteragent }
      else
        format.html { render :edit }
        format.json { render json: @masteragent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /masteragents/1
  # DELETE /masteragents/1.json
  def destroy
    @masteragent.destroy
    respond_to do |format|
      format.html { redirect_to masteragents_url, notice: 'Masteragent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_masteragent
      @masteragent = Masteragent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def masteragent_params
      #params.fetch(:masteragent, {})
      params.require(:masteragent).permit(:name)
    end
end
