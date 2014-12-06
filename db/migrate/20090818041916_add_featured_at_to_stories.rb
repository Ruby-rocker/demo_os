class AddFeaturedAtToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :featured_at, :datetime
  end

  def self.down
    drop_column :stories, :featured_at    
  end
end
