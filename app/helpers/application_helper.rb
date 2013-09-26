module ApplicationHelper
  def field_input(partial, label, record_type=nil, options={})
    render(:partial => "layouts/#{partial}_input", :locals => {
      :label => label,
      :field => record_type ? :"#{record_type}[#{label}]" : label,
      :options => options
    })
  end

  def text_input(label, record_type=nil, options={})
    field_input('text', label, record_type, options)
  end

  def password_input(label, record_type=nil, options={})
    field_input('password', label, record_type, options)
  end

  def text_area_input(label, record_type=nil, options={})
    field_input('text_area', label, record_type, options)
  end
end
