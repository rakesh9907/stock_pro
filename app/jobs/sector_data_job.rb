class SectorDataJob < ApplicationJob
  queue_as :default

  def perform(id, date)
    sector = Sector.find(id)
  end
end