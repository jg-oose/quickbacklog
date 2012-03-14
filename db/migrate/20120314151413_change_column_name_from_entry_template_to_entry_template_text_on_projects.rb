class ChangeColumnNameFromEntryTemplateToEntryTemplateTextOnProjects < ActiveRecord::Migration
  def change
    rename_column :projects, :entry_template, :entry_template_text
  end
end
