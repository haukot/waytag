class AddKindToApiUser < ActiveRecord::Migration
  def change
    add_column :api_users, :kind, :string
  end
end
