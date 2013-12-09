class ReportDecorator < Draper::Decorator
  delegate_all

  def state_class
    if object.posted?
      "success"
    elsif object.rejected? || object.bad?
      "warning"
    elsif object.post_failed?
      "danger"
    end
  end

  def published_date
    object.time.strftime("%d.%m.%Y")
  end

  def published_at
    object.time.strftime("[%H:%M]")
  end

  def published_by
    "@#{object.username}" if has_username?
  end

  def sourceable_link
    if object.sourceable
      path = "admin_#{object.sourceable.class.name.underscore.pluralize}_path".to_sym

      name = case object.sourceable
             when TwitterUser
               "@#{sourceable.screen_name}"
             when WebUser
               sourceable.ip
             else
               sourceable.class.name.gsub(/User/, ' # ') + sourceable.id.to_s
             end

      h.link_to name, h.send(path, q: { id_eq: object.sourceable.id })
    end

  end

  def state_string
    if object.rejected?
      if with_mentions?
        h.t(:with_mentions)
      elsif less_three_words?
        h.t(:less_three_words)
      elsif question?
        h.t(:question)
      elsif contains_bad_data?
        h.t(:contains_bad_data)
      elsif yell?
        h.t(:yell)
      end
    else
      h.t(object.state)
    end
  end

  def event_label_class
    if object.event_kind.prbk?
      "label-warning"
    elsif object.event_kind.dtp?
      "label-danger"
    elsif object.event_kind.cmr?
      "label-success"
    elsif object.event_kind.dps?
      "label-info"
    elsif object.event_kind.rmnt?
      "label-primary"
    end
  end

  def state_label_class
    if object.rejected? || object.bad?
      "label-warning"
    elsif object.added?
      "label-default"
    elsif object.posted?
      "label-success"
    elsif object.wating_post?
      "label-info"
    elsif object.post_failed?
      "label-danger"
    end
  end

  def userpic
    image = object.userpic
    image ||= "avatar_ulway_20.png"

    h.image_tag image, width: 20, height: 20
  end

  def can_be_published?
    !(object.posted? || object.wating_post? || object.added?)
  end

end
