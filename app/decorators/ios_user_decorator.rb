class IosUserDecorator < Draper::Decorator
  delegate_all

  def state_class
    if object.blocked?
      "warning"
    end
  end

  def activate_or_block_link
    if object.blocked?
      h.link_to "Activate", h.admin_ios_user_on_path(object),
        remote: true, method: :patch, class: 'sourceable btn btn-success'
    else
      h.link_to "Block", h.admin_ios_user_off_path(object),
        remote: true, method: :patch, class: 'sourceable btn btn-warning'
    end
  end

end
