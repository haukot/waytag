class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :slug
      t.string :name
      t.string :email
      t.string :twitter_name
      t.string :hashtag

      t.timestamps
    end
  end
end
