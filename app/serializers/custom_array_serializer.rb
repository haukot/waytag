class CustomArraySerializer < ActiveModel::ArraySerializer
  def as_json(options = {})
    data = options[:meta_data].dup if options.key? :meta_data
    data ||= {}
    data.merge(super options)
  end
end
