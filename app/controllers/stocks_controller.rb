class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :update, :destroy]
  before_action :set_industry, only: [ :industry_stocks ]

  # GET /stocks
  def index
    @stocks = Stock.all# Eager load industries
    render json: @stocks, each_serializer: StockSerializer
  end

  def industry_stocks
    @stocks = @industry.stocks
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

  def get_holc
    stock_token = params['token'] 
    # start_date = params['start_date']
    # end_date = params['end_date']
    # # end_date should be grether the start_date
    # data = ExternalApiService.new.fetch_delivery(symbol, start_date, end_date)
    # final_data = data['data'].map{ |item, index| [item['CH_TIMESTAMP'], item['CH_OPENING_PRICE'], item['CH_TRADE_HIGH_PRICE'], item['CH_TRADE_LOW_PRICE'], item['CH_CLOSING_PRICE'], item['CH_TOT_TRADED_QTY']]}

    # render json: final_data
    token = 'V/bormax3ar4UsfaFRk+pw0IsAruDnXiPDA/fKRy1JGepeARSoyguFHk3d2dbopelaESfzDPc7taKIOnXeZ/33It3BhmXQoUoP+N/Lap++wjuObSWbQTWw=='

    kit = KitHistoryService.new(token).historical_data(stock_token, '2024-01-01', '2025-01-03', 'day')
    render json: kit
  end

  private

  def set_industry
    @industry = Industry.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Industry not found' }, status: :not_found
  end

  def set_stock
    @stock = Stock.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Stock not found' }, status: :not_found
  end

  def stock_params
    params.permit(:name, :symbol, :industry_id, :category)
  end
end
