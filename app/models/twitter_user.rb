class TwitterUser < ActiveRecord::Base
  include Sourceable

  def admin?
    ["PanfilovDen", "vdv73rus", "8xx8ru"].include?(screen_name)
  end
end
