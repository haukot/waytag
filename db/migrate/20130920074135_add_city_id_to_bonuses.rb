class AddCityIdToBonuses < ActiveRecord::Migration
  def change
    add_column :bonuses, :city_id, :integer
  end
end
