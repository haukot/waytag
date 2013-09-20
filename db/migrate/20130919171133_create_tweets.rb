class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :report_id
      t.string :id_str

      t.timestamps
    end
  end
end
