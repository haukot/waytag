class TwitterUserSerializer < ActiveModel::Serializer
  attributes :id, :image, :name, :screen_name, :external_id_str, :state
end
