class CreateParagraphs < ActiveRecord::Migration
  def self.up
    create_table :paragraphs do |t|
      t.references :story
			t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :paragraphs
  end
end
