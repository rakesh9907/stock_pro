class SectorsController < ApplicationController

  before_action :set_sector, only: [:show, :update, :destroy]

  def index
    # get_response = DeliveryApiService.new.deliver_data('TCS', '30-09-2024')
    puts ExternalApiService.new.final_data
    @sectors = Sector.all
    render json: @sectors, each_serializer: SectorSerializer
  end

  def show
    sector = Sector.find(params[:id])
    render json: sector, serializer: SectorSerializer
  end

  # POST /sectors
  def create
    @sector = Sector.new(sector_params)
    if @sector.save
      render json: @sector, status: :created, serializer: SectorSerializer
    else
      render json: @sector.errors, status: :unprocessable_entity
    end
  end

  def update
    if @sector.update(sector_params)
      render json: @sector, serializer: SectorSerializer
    else
      render json: @sector.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @sector.destroy
    head :no_content
  end

  private

  def set_sector
    @sector = Sector.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Sector not found' }, status: :not_found
  end

  def sector_params
    params.require(:sector).permit(:name)
  end

end
