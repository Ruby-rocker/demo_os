module SearchHelper

  def query_label(sort, value)
    value ||= ""
    sort = sort.to_s.capitalize
    arr = sort != 'Location' && value.split(',') || []
    "<h4><b>#{arr.empty? || arr.length == 1 ? sort : sort.pluralize}</b> - <i>#{value}</i></h4>" unless value.empty?
  end
  
  

  def order_by_label(sort)
    "#{sort}"
  end
  
  def order_by_arrow
    str += dir == "desc" ? "<span class=\"inactive\">&uarr;</span>" : "<span class=\"active\">&uarr;</span>"
    str += dir == "desc" ? "<span class=\"inactive\">&darr;</span>" : "<span class=\"active\">&darr;</span>"
    str
  end
  
  def order_by_path(sort,direction)
    prms = "?"
    prms << (request.query_string.empty? ? "" : "#{request.query_string}&")
    prms << "sort=#{sort}&direction=#{direction}"
  end
  
  def order_by_link(sort)
    cur_sort = params[:sort] || "date"
    cur_dir = params[:direction] || "desc"
    links = ""
    links << link_to(order_by_label(sort), order_by_path(sort,cur_dir == "asc" ? "desc" : "asc"), :class => sort == cur_sort ? "active" : nil)
    links << link_to("&darr;", order_by_path(sort,"desc"), :class => sort == cur_sort && cur_dir == "desc" ? "active" : nil)
    links << link_to("&uarr;", order_by_path(sort,"asc"), :class => sort == cur_sort && cur_dir == "asc" ? "active" : nil)
    links
  end

  def show_all_stories
    link_to "All", search_path(:keywords => "list_all_stories")
  end
  
end