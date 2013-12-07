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
    object.time.strftime("%H:%M")
  end

  def published_by
  end

  def userpic
    image = object.userpic
    image ||= "avatar_ulway_20.png"

    h.image_tag image
  end


end
