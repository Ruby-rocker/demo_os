class Banner < ActiveRecord::Base
attr_accessible :name, :status, :photo
has_attached_file :photo
end
