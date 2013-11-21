# encoding: utf-8

class TwitterUserPopulator < BasePopulator
  permit(:id_str, :profile_image_url, :name, :screen_name, :description)

  def populate
    user = TwitterUser.find_or_create_by uid: strong_params.delete(:id_str)

    user.update(strong_params)
    user
  end

  def populate_from_omniauth(auth)
    TwitterUser.where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.profile_image_url = auth["extra"]["raw_info"]["profile_image_url"]
      user.name = auth["extra"]["raw_info"]["name"]
      user.screen_name = auth["extra"]["raw_info"]["screen_name"]
      user.description = auth["extra"]["raw_info"]["description"]

      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end

end
