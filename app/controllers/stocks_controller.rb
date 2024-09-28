class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :update, :destroy]

  # GET /stocks
  def index
    @stocks = Stock.all.includes(:industry) # Eager load industries
    render json: @stocks, each_serializer: StockSerializer
  end

  # GET /stocks/:id
  def show
    render json: @stock, serializer: StockSerializer
  end

  # POST /stocks
  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      render json: @stock, status: :created, serializer: StockSerializer
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stocks/:id
  def update
    if @stock.update(stock_params)
      render json: @stock, serializer: StockSerializer
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stocks/:id
  def destroy
    @stock.destroy
    head :no_content
  end

  private

  def set_stock
    @stock = Stock.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Stock not found' }, status: :not_found
  end

  def stock_params
    params.require(:stock).permit(:name, :industry_id)
  end
end
