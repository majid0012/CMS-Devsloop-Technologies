class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.string :designation
      t.integer :salary
      t.string :email_address
      t.string :phone_number

      t.timestamps
    end
  end
end
