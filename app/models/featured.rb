class Featured < ActiveRecord::Base
  belongs_to :story

  validates_presence_of :story_id
  validates_uniqueness_of :story_id
  
  cattr_reader :per_page
  @@per_page = 10
    
  def month
	  self.created_at.strftime('%B %y')
	end

end
