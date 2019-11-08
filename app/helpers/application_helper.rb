module ApplicationHelper

  include Pagy::Frontend

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

  def pagy_bootstrap_nav(pagy)
    link, p_prev, p_next = pagy_link_proc(pagy, 'class="page-link"'), pagy.prev, pagy.next

    html = EMPTY + (p_prev ? %(<li class="page-item prev">#{link.call p_prev, "&laquo;", 'aria-label="previous"'}</li>)
                           : %(<li class="page-item prev disabled"><a href="#" class="page-link">&laquo;</a></li>))
    pagy.series.each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
      html << if    item.is_a?(Integer); %(<li class="page-item">#{link.call item}</li>)                                                               # page link
              elsif item.is_a?(String) ; %(<li class="page-item active">#{link.call item}</li>)                                                        # active page
              elsif item == :gap       ; %(<li class="page-item gap disabled"><a href="#" class="page-link">#{pagy_t('pagy.nav.gap')}</a></li>) # page gap
              end
    end
    html << (p_next ? %(<li class="page-item next">#{link.call p_next, "&raquo;", 'aria-label="next"'}</li>)
                    : %(<li class="page-item next disabled"><a href="#" class="page-link">&raquo;</a></li>))
    %(<nav class="pagy-bootstrap-nav pagination pagination-sm justify-content-center" role="navigation" aria-label="pager"><ul class="pagination">#{html}</ul></nav>)
  end

end
