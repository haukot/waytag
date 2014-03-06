class CreateVkUsers < ActiveRecord::Migration
  def change
    create_table :vk_users do |t|
      t.string :state
      t.string :name

      t.timestamps
    end
  end
end
