class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :user_name
      t.string :title
      t.string :content
      t.string :state
      t.datetime :published_at
      t.string :seo_name
      t.string :seo_keywords
      t.string :seo_description

      t.timestamps
    end
  end
end
