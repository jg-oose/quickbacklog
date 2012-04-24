class ChangeSizeValToFloat < ActiveRecord::Migration
  class BacklogEntry < ActiveRecord::Base
  end

  def up
    add_column :backlog_entries, :size_val_f, :float

    BacklogEntry.reset_column_information
    BacklogEntry.all.each do |entry|
      entry.update_attributes!(:size_val_f => entry.size_val)
    end

    remove_column :backlog_entries, :size_val
    rename_column :backlog_entries, :size_val_f, :size_val
  end
  
  def done
    add_column :backlog_entries, :size_val_i, :float

    BacklogEntry.reset_column_information
    BacklogEntry.all.each do |entry|
      entry.update_attributes!(:size_val_i => entry.size_val)
    end

    remove_column :backlog_entries, :size_val
    rename_column :backlog_entries, :size_val_i, :size_val
  end
end
