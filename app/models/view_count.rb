class ViewCount < ActiveRecord::Base
	
	belongs_to :viewable, :polymorphic => true
  validates_uniqueness_of :ip_address, :scope => [:viewable_id, :viewable_type]
  
  acts_as_geocodable
  
  def to_location
    begin
      Graticule.service(:host_ip).new.locate(self.ip_address)
    rescue => e
      Rails.logger.warn "View Count Geolocation Failed:"
      Rails.logger.warn e.message
      nil
    end
  end
  
end