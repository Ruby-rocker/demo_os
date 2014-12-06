class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|

			t.references :user

      t.string  :title
      t.string  :path
      
      t.string  :subject
      t.string  :age
      t.string  :gender
      t.boolean :fiction
      t.integer :year, :limit => 5
      
      t.string  :location
      t.string  :author_location
      t.boolean :use_author_location
      
      t.boolean :anonymous, :default => false
      t.boolean :published
      
      t.timestamps

    end
  end

  def self.down
    drop_table :stories
  end
end
