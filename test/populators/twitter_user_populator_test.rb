# encoding: utf-8

require 'test_helper'

class TwitterUserPopulatorTest < ActiveSupport::TestCase
  test 'Test populating user and tweet from status params' do
    params = ActiveSupport::JSON.decode(load_fixture('status.json'))
    tup = TwitterUserPopulator.new(params['user'])

    user = tup.populate

    assert { user.present? }
  end

  test 'Test populating user from omni auth' do
    tup = TwitterUserPopulator.new

    auth = OmniAuth::AuthHash.new(provider: 'twitter',
                                  uid: '123545',
                                  info: {
                                    name: 'stub'
                                  },
                                  credentials: {
                                    token: 'stub'
                                  },
                                  extra: {
                                    raw_info: {
                                      profile_image_url: 'stub',
                                      name: 'stub',
                                      screen_name: 'stub',
                                      description: 'stub'
                                    }
                                  })

    user = tup.populate_from_omniauth(auth)

    assert { user.present? }
  end
end
