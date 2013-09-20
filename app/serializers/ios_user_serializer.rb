class IosUserSerializer < ActiveModel::Serializer
  attributes :id, :token, :state
end
