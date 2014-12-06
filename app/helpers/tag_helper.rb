module TagHelper
  
  
	def search_link(search_type="", query="", formatted_query=nil)
		link_to(query, "/search/#{search_type}/#{CGI.escapeHTML((formatted_query || query || "").gsub(/\/|\./,'').gsub(/\s/, '%20').downcase)}")
	end
	
  #def search_query_path(search_type="", query="")
  #  "/search/#{search_type}/#{CGI.escapeHTML(query.gsub(/[^a-z0-9\-]/,'').downcase)}"
  #end
  
	#def search_link(search_type="", query="", formatted_query=nil)
  #  query = formatted_query || query || ""
	#	link_to(query, search_query_path(search_type, CGI.escapeHTML(query.gsub(/[^a-z0-9\-]/,'').downcase)))
	#end

	def tag_link_list(list)
		list.collect{|tag| search_link('keyword', tag) }.join(", ")
	end

end
