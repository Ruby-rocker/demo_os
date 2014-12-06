class AddResetPasswordToUser < ActiveRecord::Migration
  def self.up    
    add_column :users, :password_reset_code, :string, :limit => 40
    add_column :users, :reset_at, :datetime
  end

  def self.down
    drop_column :users, :password_reset_code
    drop_column :users, :reset_at
  end
end
