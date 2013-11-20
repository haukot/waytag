class CreateBonuses < ActiveRecord::Migration
  def change
    create_table :bonuses do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
