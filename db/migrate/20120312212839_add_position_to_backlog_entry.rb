class AddPositionToBacklogEntry < ActiveRecord::Migration
  def change
    add_column :backlog_entries, :position, :integer

  end
end
