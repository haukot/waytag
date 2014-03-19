class AddVkAndYandexToCities < ActiveRecord::Migration
  def change
    add_column :cities, :vk_name, :string
    add_column :cities, :yandex_widget, :string
  end
end
