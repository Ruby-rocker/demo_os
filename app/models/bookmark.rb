class Bookmark < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :story

  validates_presence_of :user_id, :story_id
  
  validates_uniqueness_of :story_id, :scope => :user_id
  
  cattr_reader :per_page
  @@per_page = 10
    
  def month
	  self.created_at.strftime('%B %y')
	end

end
