class CreateAndroidUsers < ActiveRecord::Migration
  def change
    create_table :android_users do |t|
      t.string :token
      t.string :state

      t.timestamps
    end
  end
end
