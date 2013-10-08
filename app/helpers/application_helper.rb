module ApplicationHelper

  # ----- Sections -----

  def session_links
    render(:partial => 'home/session_links')
  end

  def notices
    render(:partial => 'home/notices')
  end

  # ----- Format-related helpers -----

  def friendly_date(date)
    time_ago_in_words(date) + ' ago'
  end

  # ----- Reusable HTML-related helpers -----

  def render_table(table_type, records, columns)
    render(:partial => 'layouts/table', :locals => {
      :table_type => table_type,
      :records    => records,
      :columns    => columns
    })
  end

  def render_list(list_type, items)
    render(:partial => 'layouts/list', :locals => {
      :list_type  => list_type,
      :items      => items
    })
  end

  def form_field(f, field_type, field_name, options={})
    render(:partial => 'layouts/form_field', :locals => {
      :f          => f,
      :field_type => field_type,
      :field_name => field_name,
      :options    => options
    })
  end

  def form_select(f, field_name, options)
    render(:partial => 'layouts/form_select', :locals => {
      :f          => f,
      :field_name => field_name,
      :options    => options_for_select(options)
    })
  end

  def code_editor(f, field_name, language, options={})
    form_field(f, :text_area, field_name, {
      :class           => 'code-editor',
      :'data-language' => language
    }.merge(options))
  end
end
