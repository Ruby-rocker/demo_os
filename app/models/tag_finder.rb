class TagFinder

	def self.tag_counts_for_sorting(options = {})
	  Tag.find(:all, find_options_for_tag_counts(options))
	end
        
  def self.find_options_for_tag_counts(options = {})
    options = options.dup
    scope = scope(:find)
    character = params[:with].try(:downcase)

      conditions = []
      conditions << send(:sanitize_conditions, options.delete(:conditions)) if options[:conditions]
      conditions << send(:sanitize_conditions, scope[:conditions]) if scope && scope[:conditions]
      conditions << "#{Tagging.table_name}.taggable_type = #{quote_value(base_class.name)}"
      conditions << type_condition unless descends_from_active_record? 
      # added by mehul to show only published stories
      conditions << "#{table_name}.published = 1"
      conditions << "lower(name) LIKE ('#{character}%')"
      # added by mehul to show only published stories
      conditions.compact!
      conditions = conditions.join(" AND ")
          
      joins = ["INNER JOIN #{table_name} ON #{table_name}.#{primary_key} = #{Tagging.table_name}.taggable_id"]
      joins << options.delete(:joins) if options[:joins]
      joins << scope[:joins] if scope && scope[:joins]
      joins = joins.join(" ")
          
      options = { :conditions => conditions, :joins => joins }.update(options)
          
      Tag.options_for_counts(options)
  end
end