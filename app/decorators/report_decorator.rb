class ReportDecorator < Draper::Decorator
  delegate_all

  def state_class
    if object.posted?
      "success"
    elsif object.rejected? || object.bad?
      "warning"
    elsif object.post_failed?
      "danger"
    elsif object.deleted?
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
    case object.sourceable
    when TwitterUser
      "@#{object.sourceable.screen_name}"
    when VkUser
      "#{object.sourceable.name}"
    else
      ""
    end
  end

  def userpic_url
    case object.sourceable
    when TwitterUser
      sourceable.profile_image_url
    when VkUser
      h.image_url "vk.png"
    else
      h.image_url "waytag.png"
    end
  end

  def userpic
    h.image_tag userpic_url, width: 20, height: 20
  end


  def sourceable_link
    if object.sourceable
      path = "admin_#{object.sourceable.class.name.underscore.pluralize}_path".to_sym

      name = case object.sourceable
             when TwitterUser
               "@#{sourceable.screen_name}"
             when WebUser
               sourceable.ip
             when VkUser
               sourceable.name
             else
               sourceable.class.name.gsub(/User/, ' # ') + sourceable.id.to_s
             end

      h.link_to name, h.send(path, q: { id_eq: object.sourceable.id })
    end

  end

  def state_string
    if object.rejected?
      if object.text_empty?
        h.t(:empty_text)
      elsif has_obscenity?
        RussianObscenity.find(object.text)
      elsif with_mentions?
        h.t(:with_mentions)
      elsif less_three_words?
        h.t(:less_three_words)
      elsif question?
        h.t(:question)
      elsif contains_bad_data?
        h.t(:contains_bad_data)
      elsif yell?
        h.t(:yell)
      else
        h.t(object.state)
      end
    else
      h.t(object.state)
    end
  end

  def can_be_published?
    !(object.posted? || object.wating_post? || object.added?)
  end

  def composed_text
    via = " via @#{object.sourceable.screen_name}" if object.sourceable.kind_of?(TwitterUser)

    _text = object.time.strftime('[%H:%M]') + " {?} ##{object.city.hashtag}#{via}"

    text = object.text.truncate(truncate_to(_text))

    _text.gsub(/\{\?\}/, text)
  end

  def safe_text
    if Rails.env.staging? || Rails.env.development?
      composed_text.gsub(/@|#/, '')
    else
      composed_text
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
    elsif object.deleted?
      "label-danger"
    end
  end

  private

  def truncate_to(text)
    143 - text.size
  end

end
