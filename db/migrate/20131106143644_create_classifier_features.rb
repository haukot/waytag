class CreateClassifierFeatures < ActiveRecord::Migration
  def change
    create_table :classifier_features do |t|
      t.string :name
      t.string :category
      t.integer :count, default: 1

      t.timestamps
    end
  end
end
