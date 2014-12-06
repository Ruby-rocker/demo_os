class DataFile < ActiveRecord::Base
	attr_accessor :upload
	validates_presence_of :upload
	def self.save(upload)
    	name =  upload['datafile'].original_filename
    	directory = "public/images/pages/home/slideshow"
    	# create the file path
    	path = File.join(directory, name)
    	# write the file
    	File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  	end
end
