class RemoveAndroidUsersAndIosUsers < ActiveRecord::Migration
  def change
    drop_table :ios_users
    drop_table :android_users
  end
end
