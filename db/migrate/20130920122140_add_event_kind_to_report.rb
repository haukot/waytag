class AddEventKindToReport < ActiveRecord::Migration
  def change
    add_column :reports, :event_kind, :string
  end
end
