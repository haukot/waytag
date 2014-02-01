# encoding: utf-8

class SourceablePopulator < BasePopulator
  def populate
    klass = "#{params[:type]}_user".camelize.constantize

    if klass == WebUser
      sourceable = klass.find_or_create_by(ip: params[:token])
    else
      sourceable = klass.find_or_create_by(token: params[:token])
    end

    params.delete(:type)
    sourceable.update(params)
    sourceable
  rescue NameError
    nil
  end
end
