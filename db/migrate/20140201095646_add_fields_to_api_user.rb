class AddFieldsToApiUser < ActiveRecord::Migration
  def change
    add_column :api_users, :accuracy, :integer
    add_column :api_users, :push_token, :string
    add_column :api_users, :type, :string
  end
end
