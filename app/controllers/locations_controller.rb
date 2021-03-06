class LocationsController < ApplicationController
  include LocationsHelper
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    # MARTA API URL
    bus_api_url = "http://developer.itsmarta.com/BRDRestService/RestBusRealTimeService/GetAllBus"

    # Use our helper method to parse the data into an array of all buses in the system
    @busses = fetch_buses_from_api(bus_api_url)

    if @location.distance == 0.06
      @busses.select! { |bus| is_06mi_nearby?(@location.latitude, @location.longitude, bus["LATITUDE"], bus["LONGITUDE"])}
    elsif @location.distance == 0.02
      @busses.select! { |bus| is_02mi_nearby?(@location.latitude, @location.longitude, bus["LATITUDE"], bus["LONGITUDE"])}
    elsif @location.distance == 1.0
      @busses.select! { |bus| is_1mi_nearby?(@location.latitude, @location.longitude, bus["LATITUDE"], bus["LONGITUDE"])}
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:street_address, :city, :latitude, :longitude, :distance)
    end
end
