class ReportSerializer < ActiveModel::Serializer
  attributes :id, :city_id, :text, :time, :state, :source_id, :source_type, :source_kind
end
