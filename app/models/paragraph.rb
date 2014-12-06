class Paragraph < ActiveRecord::Base
  
  acts_as_taggable
  
  belongs_to :story
  has_one :user, :through => :story
  
  validates_presence_of :story_id
  
  has_one :asset, :as => :attachable, :dependent => :destroy
  
	def is_empty?
    (!self.body || self.body.empty?) && (!self.asset || self.asset.empty?)
	end
	
	def asset=(value)
		write_attribute(:asset, (read_attribute(:asset) ? read_attribute(:asset).src = value : create_asset(:src => value).save))
	end
	
end
