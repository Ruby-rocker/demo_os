class AddBuzzCols < ActiveRecord::Migration
  def self.up
    add_column :users, :buzz_me, :boolean, :default => true
    add_column :users, :buzz_me_mail, :boolean, :default => true
  end

  def self.down
    remove_column :users, :buzz_me
    remove_column :users, :buzz_me_mail
  end
end
