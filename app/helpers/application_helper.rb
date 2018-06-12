module ApplicationHelper

  def filter(klass, field, objects, submitted, display, selected)
    select_tag(
      "#{klass}[#{field}][]",
      options_for_select(
        objects.map { |o| [o.send(display), o.send(submitted)] },
        selected
      ),
      multiple: true,
      class: 'selectpicker',
      'data-actions-box': 'true',
      'data-live-search': 'true',
      'data-width': '100%'
    )
  end

  def editable(obj, field, detail = nil, options = {})
    path = []
    initial = obj.send(field)

    if initial.is_a?(ActiveRecord::Associations::CollectionProxy)
      path << "#{field}[*]"
      path << detail
      initial = initial.map { |i| i.send(detail) }.join(', ')
    else
      path << field

      if detail
        path << detail
        initial = initial.send(detail)
      end
    end

    css = ['editable']
    css << 'editable-empty' if initial.blank?
    css << 'badge' if field == :severity_internal

    content_tag(
      :a,
      initial.blank? ? 'Empty' : initial,
      class: css.join(' '),
      style: options[:style],
      tabindex: 0,
      data: {
        toggle: 'popover',
        uuid: obj.id,
        element: SecureRandom.alphanumeric,
        field: field.to_s,
        path: path.compact.join('.')
      }
    )
  end

end
