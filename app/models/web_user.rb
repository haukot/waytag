class WebUser < ActiveRecord::Base
  include Sourceable

  def token=(token)
    self.ip = token
  end

  def token
    self.ip
  end

end
