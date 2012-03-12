class CreateBacklogEntries < ActiveRecord::Migration
  def change
    create_table :backlog_entries do |t|
      t.string :title
      t.text :description
      t.string :category
      t.integer :size

      t.timestamps
    end
  end
end
