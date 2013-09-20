class CreateApiUsers < ActiveRecord::Migration
  def change
    create_table :api_users do |t|
      t.string :token
      t.string :state

      t.timestamps
    end
  end
end
