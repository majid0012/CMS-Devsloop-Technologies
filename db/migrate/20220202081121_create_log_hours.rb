class CreateLogHours < ActiveRecord::Migration[6.1]
  def change
    create_table :log_hours do |t|
      t.datetime :date
      t.string :time_spent
      t.text :work_description
      t.references :project

      t.timestamps
    end
  end
end
