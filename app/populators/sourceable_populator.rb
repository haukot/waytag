# encoding: utf-8

class SourceablePopulator < BasePopulator
  def populate
    klass = "#{params[:type]}_user".camelize.constantize

    if klass == WebUser
      klass.find_or_create_by(ip: params[:token])
    else
      klass.find_or_create_by(token: params[:token])
    end
  rescue NameError
    nil
  end
end
