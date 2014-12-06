class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.references :user
      t.references :story
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
