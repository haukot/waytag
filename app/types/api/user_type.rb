class Api::UserType < ApiUser
  include BaseType

  permit :kind, :token, :push_token
end
