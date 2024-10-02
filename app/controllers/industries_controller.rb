class IndustriesController < ApplicationController
  before_action :set_industry, only: [:show, :update, :destroy]

  # GET /industries
  def index
    @industries = Industry.all.includes(:sector) # Eager load sectors
    render json: @industries, each_serializer: IndustrySerializer
  end

  # GET /industries/:id
  def show
    render json: @industry, serializer: IndustrySerializer
  end

  # POST /industries
  def create
    @industry = Industry.new(industry_params)
    if @industry.save
      render json: @industry, status: :created, serializer: IndustrySerializer
    else
      render json: @industry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /industries/:id
  def update
    if @industry.update(industry_params)
      render json: @industry, serializer: IndustrySerializer
    else
      render json: @industry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /industries/:id
  def destroy
    @industry.destroy
    head :no_content
  end

  private

  def set_industry
    @industry = Industry.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Industry not found' }, status: :not_found
  end

  def industry_params
    params.permit(:name, :sector_id)
  end
end
