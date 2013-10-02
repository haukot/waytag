class CreateCityStreets < ActiveRecord::Migration
  def change
    create_table :city_streets do |t|
      t.string :name
      t.integer :rate
      t.integer :city_id

      t.timestamps
    end
  end
end
