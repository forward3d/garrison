module ApplicationHelper

  def editable(obj, field, detail = nil)
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

    content_tag(
      :a,
      initial.blank? ? 'Empty' : initial,
      class: css.join(' '),
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
