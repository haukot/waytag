class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :image
      t.string :name
      t.string :screen_name
      t.string :external_id_str
      t.string :state

      t.timestamps
    end
  end
end
