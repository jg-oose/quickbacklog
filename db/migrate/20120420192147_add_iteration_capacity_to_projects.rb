class AddIterationCapacityToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :iteration_capacity, :float

  end
end
