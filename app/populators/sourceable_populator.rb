# encoding: utf-8

class SourceablePopulator < BasePopulator
  def populate
    klass = "#{params[:type]}_user".camelize.constantize
    klass.find_or_create_by(token: params[:token])
  end
end
