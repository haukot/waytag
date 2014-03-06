class VkUser < ActiveRecord::Base
  include Sourceable

  def screen_name
    name
  end

  def profile_image_url
    "vk.png"
  end
end
