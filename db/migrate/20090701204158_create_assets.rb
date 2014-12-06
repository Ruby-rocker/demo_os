class CreateAssets < ActiveRecord::Migration
  def self.up
		create_table :assets do |t|		
	    t.references :attachable, :polymorphic => true
	
	    t.string :src_file_name
	    t.string :src_content_type
	    t.string :src_file_size
	    t.datetime :src_updated_at

      t.timestamps
    end
  end

  def self.down
  	drop_table :assets
  end
end
