class AddFieldsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :accuracy, :integer
  end
end
