# encoding: utf-8

class TwitterUserPopulator < BasePopulator
  permit(:id_str, :profile_image_url, :name, :screen_name, :description)

  def create
    TwitterUser.find_or_create_by strong_params
  end

end
