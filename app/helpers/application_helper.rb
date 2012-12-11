module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def header_row(column_names, options = {})
    html = "<tr>"
    column_names.each do |k, v| 
      html += '<th scope="col">'
      # binding.pry
      html += options[:f].text_field :column_names, :class => "separate_fields text_area" if options[:editable]
      html += (v || "&nbsp;") + '</th>' unless options[:editable]
    end
    html += '<input id="submit-column-names" type="text_field" name="drill[column_names]" value="' + column_names.to_s + '" />' 
    html += '</tr>'
  end

#delete this
  def path_aware_link_to_add_fields(name, f, association, path)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    split_path = path.split('/')
    prefix = split_path[-2] == "views" ?  "" : split_path.last(2).join('/') + "/"
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(prefix + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
