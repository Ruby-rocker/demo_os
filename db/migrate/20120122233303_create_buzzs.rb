class CreateBuzzs < ActiveRecord::Migration
  def self.up
    create_table :buzzs do |t|
      t.string  :subject
      t.text  :body
      t.integer :from_user_id
      t.integer :to_user_id
      t.integer :root_id
      t.boolean :from_user_deleted
      t.boolean :to_user_deleted
            
      t.timestamps
    end
  end

  def self.down
    drop_table :buzzs
  end
end
