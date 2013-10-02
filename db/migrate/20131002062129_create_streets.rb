class CreateStreets < ActiveRecord::Migration
  def change
    create_table :streets do |t|
      t.integer :city_id
      t.string :name
      t.integer :rate

      t.timestamps
    end
  end
end
