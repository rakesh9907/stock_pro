class IndustryDataJob < ApplicationJob
  queue_as :default

  def perform(id, date)
    industry = Industry.find(id)
  end
  
end