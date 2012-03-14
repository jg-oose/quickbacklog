class CreateProjects < ActiveRecord::Migration
  class BacklogEntry < ActiveRecord::Base
  end

  class Project < ActiveRecord::Base
  end

  def up
    create_table :projects do |t|
      t.string :name
      t.text :vision
      t.text :entry_template
      t.text :size_scale
  end
      add_column :backlog_entries, :project_id, :integer

      Project.create(name: "Dein naechstes Projekt!",
        vision: "Beschreib die Essenz Deines Projekt in wenigen Worten ... Template",
        size_scale: {
          "0" => 0, "1" => 1, "2" => 2, "3" => 3, "5" => 5,
          "8" => 8, "13" => 13, "21" => 21, "40" => 40, "100" => 100},
        entry_template: "_Story_\n...\n\n_Howto Demo_\n...\n\n_Value_\n...\n\n_Risks_\n...\n\n_What else you need_...")
        
      BacklogEntry.reset_column_information
      BacklogEntry.all.each do |entry|
        entry.update_attributes!(:project_id => 1)
      end
  end  

  def down
    remove_column :backlog_entries, :project_id
    drop_table :projects
  end
end