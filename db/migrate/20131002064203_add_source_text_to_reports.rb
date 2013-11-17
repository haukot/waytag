class AddSourceTextToReports < ActiveRecord::Migration
  def change
    add_column :reports, :source_text, :string
  end
end
