class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]

  def get_positions
    @positions = Shop.select(:lat, :lng).where(:subagent_id => params["subagent_id"])

    @hash = Gmaps4rails.build_markers(@positions) do |position, marker|
      marker.lat position.lat
      marker.lng position.lng
    end

    return render json: { data: @hash}
  end

  def position_update
    Shop.where(:id => params["id"]).update(lat: params["lat"], lng: params["lng"])
      return { random_param_name: params["id"]}
  end
  # GET /shops
  # GET /shops.json
  def index
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagents = @agent.subagents.find(params["subagent_id"])
    @shops = Shop.all.where(subagent_id: params["subagent_id"])
    @positions = Shop.select(:lat, :lng, :name).where(:subagent_id => params["subagent_id"])
    @hash = Gmaps4rails.build_markers(@positions) do |position, marker|
      marker.lat  position.lat
      marker.lng  position.lng
      marker.title position.name
      #marker.json({ name: position.name })
      marker.infowindow render_to_string(:partial => "info",
              :locals => {:name => position.name, :lat => position.lat, :lng => position.lng})

    end

  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagents = @agent.subagents.find(params["subagent_id"])
    @shop = Shop.find(params["id"])
    #render :layout => "layout_4"
  end

  # GET /shops/new
  def new
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagent = @agent.subagents.find(params["subagent_id"])
    @shop = @subagent.shops.build
    #@shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagent = @agent.subagents.find(params["subagent_id"])
    @shop = Shop.find(params["id"])
  end

  # POST /shops
  # POST /shops.json
  def create
    @masteragent = Masteragent.find(params["masteragent_id"])
    @agent = @masteragent.agents.find(params["agent_id"])
    @subagents = @agent.subagents.find(params["subagent_id"])
    @shop = @subagents.shops.build(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to masteragent_agent_subagent_shops_path, notice: 'Shop was successfully created.' }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to masteragent_agent_subagent_shops_path, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shop_params
      #params.fetch(:shop, {})
      params.require(:shop).permit(:name, :subagent_id, :agent_id, :masteragent_id)
    end
end
