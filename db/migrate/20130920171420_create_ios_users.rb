class CreateIosUsers < ActiveRecord::Migration
  def change
    create_table :ios_users do |t|
      t.string :token
      t.string :state

      t.timestamps
    end
  end
end
