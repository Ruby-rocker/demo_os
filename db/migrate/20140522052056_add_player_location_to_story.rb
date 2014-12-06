class AddPlayerLocationToStory < ActiveRecord::Migration
  def self.up
	add_column :stories, :player_location, :boolean
  end

  def self.down
	remove_column :stories, :player_location
  end
end
