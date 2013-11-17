class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :profile_image_url
      t.string :name
      t.string :screen_name
      t.string :id_str
      t.string :state
      t.string :description

      t.timestamps
    end
  end
end
