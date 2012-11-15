module ApplicationHelper
  def link_to_add_fields(name, f, association, path)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    split_path = path.split('/')
    
    prefix = split_path[-2] == "views" ?  "" : split_path.last(2).join('/') + "/"
    # binding.pry unless prefix.size > 1
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(prefix + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
