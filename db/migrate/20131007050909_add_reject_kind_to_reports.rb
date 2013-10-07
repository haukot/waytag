class AddRejectKindToReports < ActiveRecord::Migration
  def change
    add_column :reports, :reject_kind, :string
  end
end
