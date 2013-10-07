class SetupGreenMidget < ActiveRecord::Migration
  def up
    create_table :green_midget_records do |t|
      t.string   :key
      t.integer  :value
      t.datetime :updated_at
    end
    add_index :green_midget_records, :key
    add_index :green_midget_records, :updated_at
  end

  def down
    drop_table :green_midget_records
  end
end
