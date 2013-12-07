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

  def userpic
    image = object.userpic
    image ||= "avatar_ulway_20.png"

    h.image_tag image, width: 20, height: 20
  end


end
