class GeocodesController < ApplicationController

  def index
	
	  conditions = nil
	
    stories = params[:stories] ? params[:stories].split(",").uniq : []
    #order = params[:order] && params[:order].match(/(created_at|stories.title)/) || 'geocodes.created_at'
    #direction = params[:direction] && params[:direction].match(/(asc|desc)/) || 'asc'
    offset = params[:offset] || 0 #params[:offset] && params[:offset].match(/[0-9]*/) : params[:offset] || 0
    limit = params[:limit] && params[:limit].match(/[\d]*/) || 99999
    
    conditions = ["geocodes.query != 'n/a'", "stories.published = true"]
    unless stories.empty?
      #story_id_string = stories.collect{|id| id.to_s + (id == stories.last ? "" : ",")}
      conditions << "(`geocodings`.`geocodable_id` IN (#{stories.join(',')}))"
    end
    
    @geocodes = Geocode.find_by_sql("
      SELECT geocodes.query, geocodes.longitude, geocodes.latitude, COUNT(stories.id) AS count
		  FROM geocodes
		  INNER JOIN geocodings ON geocodes.id = geocodings.geocode_id AND geocodings.geocodable_type = 'Story'
		  INNER JOIN stories ON geocodings.geocodable_id = stories.id
      WHERE #{conditions.join(" AND ")} AND geocodings.geocodable_type = 'Story'
		  GROUP BY geocodes.query, geocodes.longitude, geocodes.latitude
		  ORDER BY geocodings.created_at ASC
		  LIMIT #{limit} 
		  OFFSET #{offset}
    ")
    
    
  	respond_to do |format|
		  format.html { render :text =>  @geocodes.to_json.inspect }
		  format.json  { render :json =>  @geocodes.to_json }
	  end
	  
	end

end