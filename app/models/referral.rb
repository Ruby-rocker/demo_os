class Referral < Tableless
  column :name, :string
  column :email, :string
  column :friend_email, :string
  column :message, :text
  column :story_title
  column :referring_url
  
  validates_presence_of :name, :email, :friend_email, :story_title, :referring_url, :message
  
  validates_format_of :email, :with => %r{\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z}i, :message => "Please provide a valid email. (ex: xxx@yyy.zzz)"
  validates_format_of :friend_email, :with => %r{\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z}i, :message => "Please provide a valid email for your friend. (ex: xxx@yyy.zzz)"
end