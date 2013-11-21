# encoding: utf-8

class TwitterUserPopulator < BasePopulator
  permit(:id_str, :profile_image_url, :name, :screen_name, :description)

  def populate
    user = TwitterUser.find_or_create_by id_str: strong_params.delete(:id_str)

    user.update(strong_params)
    user
  end

end
