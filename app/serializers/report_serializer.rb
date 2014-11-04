class ReportSerializer < ActiveModel::Serializer
  attributes :id, :time, :event_kind, :text, :published_at,
             :published_by, :userpic_url, :longitude, :latitude, :accuracy,
             :created_at, :updated_at
end
