class ApiUserSerializer < ActiveModel::Serializer
  attributes :id, :token, :state
end
