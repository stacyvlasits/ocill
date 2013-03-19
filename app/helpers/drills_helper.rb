module DrillsHelper
  def nested_folder
    '/drills/' + @drill.type.to_s.underscore.pluralize + '/'
  end
  
  def show_headers(drill)
    html = "<thead><tr>"
    html += '<th scope="col">' + ( drill.title || "&nbsp;" ) + '</th>'
    drill.headers.each do |h| 
      html += '<th scope="col">'
      html += ( h.title || "&nbsp;") + '</th>'
    end
    html += '</tr></thead>'
  end
end
