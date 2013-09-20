class CitySerializer < ActiveModel::Serializer
  attributes :id, :slug, :name, :email, :twitter_name, :hashtag
end
