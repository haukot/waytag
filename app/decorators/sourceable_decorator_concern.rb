module SourceableDecoratorConcern

  def state_class
    if object.blocked?
      "warning"
    end
  end

  def reports_link
    h.link_to object.reports.count, h.admin_reports_path(q: { sourceable_id_eq: object.id, sourceable_type_eq: object.class.name })
  end

end
