class CreateJoinTableProjectResource < ActiveRecord::Migration[6.1]
  def change
    create_join_table :projects, :resources do |t|
      t.index [:project_id, :resource_id]
      t.index [:resource_id, :project_id]
    end
  end
end
