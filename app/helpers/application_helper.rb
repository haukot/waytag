module ApplicationHelper
  def default_search_form_options(options = {})
    { method: 'get', html: { class: 'form-search' }, defaults: { label: false, required: false } }.merge(options)
  end

  def edit_and_destroy_buttons(edit_path, destroy_path)
    content_tag :div, class: 'btn-group' do
      link_to('Edit', edit_path, edit_button_params) +
      link_to('Destroy', destroy_path, destroy_button_params)
    end
  end

  def edit_and_destroy_buttons_vertical(edit_path, destroy_path)
    content_tag :div, class: 'btn-group-vertical' do
      link_to('Edit', edit_path, edit_button_params) +
      link_to('Destroy', destroy_path, destroy_button_params)
    end
  end

  def admin_destroy_button(path)
    link_to 'Destroy', path, destroy_button_params.merge(class: 'btn btn-danger')
  end

  def right_button_params
    { class: 'btn btn-default pull-right', role: 'button' }
  end

  def edit_button_params
    { class: 'btn btn-primary', role: 'button' }
  end

  def destroy_button_params
    {
      method: :delete,
      data: { confirm: 'Are you sure?' },
      class: 'btn btn-danger',
      role: 'button'
    }
  end

  def real_f(real)
    format('%.3f', real)
  end
end
