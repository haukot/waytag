class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :city_id
      t.string :text
      t.datetime :time
      t.string :state
      t.string :sourceable_id
      t.string :sourceable_type
      t.string :source_kind
      t.float  :longitude
      t.float  :latitude
      t.string :id_str

      t.timestamps
    end
  end
end
