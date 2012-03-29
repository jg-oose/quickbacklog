class AddCutFromIdToBacklogEntry < ActiveRecord::Migration
  def change
    add_column :backlog_entries, :cut_from_id, :integer

  end
end
