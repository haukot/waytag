class AddFieldsToTwitterUser < ActiveRecord::Migration
  def change
    add_column :twitter_users, :provider, :string
    add_column :twitter_users, :uid, :string
    add_column :twitter_users, :oauth_token, :string
    add_column :twitter_users, :oauth_expires_at, :datetime
  end
end
