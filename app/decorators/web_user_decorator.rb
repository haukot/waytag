class WebUserDecorator < Draper::Decorator
  delegate_all

  include SourceableDecoratorConcern

  def activate_or_block_link
    if object.blocked?
      h.link_to 'Activate', h.admin_web_user_on_path(object),
                remote: true, method: :patch, class: 'sourceable btn btn-success'
    else
      h.link_to 'Block', h.admin_web_user_off_path(object),
                remote: true, method: :patch, class: 'sourceable btn btn-warning'
    end
  end
end
