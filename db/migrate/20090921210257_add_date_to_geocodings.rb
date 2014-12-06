class AddDateToGeocodings < ActiveRecord::Migration
  def self.up
    add_column :geocodings, :created_at, :datetime
  end

  def self.down
    drop_column :geocodings, :created_at
  end
end
