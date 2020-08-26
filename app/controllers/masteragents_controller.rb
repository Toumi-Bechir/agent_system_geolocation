class MasteragentsController < ApplicationController
  before_action :set_masteragent, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :redirect_usr

  # GET /masteragents
  # GET /masteragents.json
  def createauth
    @user = User.new(:email => params["email"], :password => params["password"], :password_confirmation => params["password_confirmation"])
    @user["role_id"] = 2
    @user["struct_id"] = params["stid"]
    @user["landing_link"] = masteragent_agents_path(params["stid"])
    respond_to do |format|
      if @user.save
        @master = Masteragent.find(params["stid"])
        @master.account = true
        @master.save
        format.html { redirect_to @user["landing_link"], notice: 'Credentials was successfully created.'}
        format.json { render :show, status: :created, location: @subagent }
      else
        format.html { redirect_to masteragents_path, notice: 'Credentials was not created.'}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    params[:id] = 22
    @user = User.new
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
      marker.infowindow render_to_string(:partial => "info",
              :locals => {:name => position.name, :lat => position.lat, :lng => position.lng })

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
    def access_managment
      case current_user.role.name
      when "subagent"
        @result = "nok"

      when "agent"
        @result = "nok"

      when "master"
        @result = "nok"


      when "admin"
        @result = "ok"

      else
        @result = "nok"
      end
    end

end
