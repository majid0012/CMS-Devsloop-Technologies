class CreateMilestones < ActiveRecord::Migration[6.1]
  def change
    create_table :milestones do |t|
      t.string :title
      t.string :description
      t.integer :budget
      t.references :project

      t.timestamps
    end
  end
end
