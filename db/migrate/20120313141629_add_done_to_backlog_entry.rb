class AddDoneToBacklogEntry < ActiveRecord::Migration
  class BacklogEntry < ActiveRecord::Base
  end

  def up
    add_column :backlog_entries, :done, :boolean

    BacklogEntry.reset_column_information
    BacklogEntry.all.each do |entry|
      entry.update_attributes!(:done => false)
    end
  end
  
  def done
    remove_column :backlog_entries, :done
  end
end
