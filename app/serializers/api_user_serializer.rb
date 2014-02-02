class ApiUserSerializer < ActiveModel::Serializer
  root false
  attributes :token, :push_token, :push_enabled

  def push_enabled
    (object.push_token && !object.push_token.empty?) ? true : false
  end
end
