class CreateWebUsers < ActiveRecord::Migration
  def change
    create_table :web_users do |t|
      t.string :ip
      t.string :state

      t.timestamps
    end
  end
end
