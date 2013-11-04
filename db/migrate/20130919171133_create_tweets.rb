class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :report_id
      t.integer :twitter_user_id
      t.string  :id_str
      t.boolean :retweeted
      t.float   :longitude
      t.float   :latitude
      t.string  :text
      t.string  :in_reply_to_status_id_str
      t.string  :in_reply_to_user_id_str
      t.datetime :external_created_at

      t.timestamps
    end
  end
end
