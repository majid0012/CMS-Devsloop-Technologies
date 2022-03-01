class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.integer :project_type
      t.datetime :start_date
      t.datetime :submission_date
      t.integer :project_status

      t.timestamps
    end
  end
end
