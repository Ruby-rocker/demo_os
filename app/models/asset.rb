require 'paperclip'

class Asset < ActiveRecord::Base
  belongs_to :user
	belongs_to :attachable, :polymorphic => true
	
	has_attached_file :src,
		:styles => {
	    :thumb=> "86x86#",
	    :small  => "180x110>",
	    :medium => "327x200>",
	    :large =>   "500x400>",
	    :xlarge =>   "700x500>" 
	    },
 	  :path => "system/srcs/:id/:style/:basename.:extension",
    :storage => "s3",
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
	
	attr_protected :src_file_name, :src_content_type, :src_file_size, :src_updated_at
	
	validates_attachment_presence :src
	
	def empty?
    self.src
	end
	
	def content_type
		return self.src.content_type
	end
	
	def url(size=:original)
		return self.src.url(size)
	end
	
end
