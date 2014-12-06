class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      
      t.column :dob,                    	 :datetime
      t.column :bio,                    	 :string, :limit => 40
      t.column :interests,                 :string, :limit => 40
      t.column :gender,                 	 :boolean      		
			
			t.column :city,                      :string, :limit => 100, :default => '', :null => true
			t.column :state,                     :string, :limit => 100, :default => '', :null => true
			t.column :country,                   :string, :limit => 100, :default => '', :null => true
			t.column :latitude,                  :float, :precision => 9, :scale => 6
      t.column :longitude,                 :float, :precision => 9, :scale => 6 
      
			t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :ip_address,								 :string, :limit => 40
      
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      
      t.column :activation_code,           :string, :limit => 40
      t.column :activated_at,              :datetime

			t.column :agreed,										 :boolean

			t.timestamps
    end
    add_index :users, :login, :unique => true
    
    u = User.new
    u.login = 'onestory'
    u.email = 'spencer@citrusme.com'
    u.password = u.password_confirmation = 'twostory'
    u.roles = [Role.first]
    u.ip_address = '68.99.126.86'
    u.agreed = true
    u.save
    
    u.activate!
    
  end
  
  def self.down
    drop_table "users"
  end
end


