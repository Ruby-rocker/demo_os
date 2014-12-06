class AddLocationInfoToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :state, :string
    add_column :stories, :country, :string
  end

  def self.down
    remove_column :stories, :state
    remove_column :stories, :country
  end
end
