class AlertsController < ApplicationController
  before_action :set_alert, only: %i[show update destroy]
  before_action :set_alert_item, only: %i[show_item, update_item, destroy_item]
  
  def index
    @alerts = Alert.all
    render json: @alerts, each_serializer: AlertSerializer
  end

  def show
    render json: @alert, serializer: AlertSerializer
  end

  def create
    @alert = Alert.new(alert_params)
    if @alert.save
      render json: @alert, serializer: AlertSerializer
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end

  def update
    if @alert.update(alert_params)
      render json: @alert, serializer: AlertSerializer
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @alert.destroy
    render json: @alert, serializer: AlertSerializer
  end

  # /////////////////////////////////////////////////Alert Item /////////////////////////////////

  # def show_item
  #   render json: @alert_item, serializer: AlertItemSerializer
  # end

  # def create_item
  #   @alert_item = AlertItem.new(alert_item_params)
  #   if @alert_item.save
  #     render json: @alert_item, serializer: AlertItemSerializer
  #   else
  #     render json: @alert_item.errors, status: :unprocessable_entity
  #   end
  # end

  # def update_item
  #   if @alert_item.update(alert_item_params)
  #     render json: @alert_item, serializer: AlertItemSerializer
  #   else
  #     render json: @alert_item.errors, status: :unprocessable_entity
  #   end
  # end

  # def destroy_item
  #   @alert_item.destroy
  #   render json: @alert, serializer: AlertSerializer
  # end

  private

  def set_alert
    @alert = Alert.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to alerts_url, alert: 'Alert not found.'
  end

  def alert_params
    binding.pry
    params.permit(:name)
  end

  # def set_alert_item
  #   @alert_item = Alert.find(params[:id])
  # end

  def alert_item_params
    params.require(:alert_item).permit(:stock_id, :price, :date, :alert_id)
  end
end
