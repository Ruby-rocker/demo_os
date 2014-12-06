class AddTinymce < ActiveRecord::Migration
  def self.up
    add_column :stories, :body,    :text
    add_column :assets,  :user_id, :integer
    #move current paragraphs to body...
    
    Story.all.each do |story|
      paragraphs = Paragraph.find(:all, :conditions => {:story_id => story.id})
      body = ""
      paragraphs.each do |paragraph|
        if !paragraph.body.nil?
          if paragraph.asset
            body += "<img src='#{paragraph.asset.src.url(:large)}' style='float:left;' />"
          end
          body += "<p>"
          body += paragraph.body 
          body += "</p>"
        end
      end
      story.body = body
      story.save
    end
    
  end

  def self.down
    remove_column :stories, :body
    remove_column :assets, :user_id
  end
end
