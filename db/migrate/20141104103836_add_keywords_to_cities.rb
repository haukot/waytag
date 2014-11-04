class AddKeywordsToCities < ActiveRecord::Migration
  def change
    add_column :cities, :keywords, :string
  end
end
