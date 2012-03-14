class ChangeColumnNameFromSizeToSizeValOnBacklogEntry < ActiveRecord::Migration
  def change
    rename_column :backlog_entries, :size, :size_val
  end
end
