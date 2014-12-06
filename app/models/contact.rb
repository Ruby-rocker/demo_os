class Contact < Tableless
  column :name, :string
  column :email, :string
  column :message, :text
  validates_presence_of :name, :email, :message
  validates_format_of :email, :with => %r{\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z}i, :message => "Please provide a valid email. (ex: xxx@yyy.zzz)"
end