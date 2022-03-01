class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.integer :invoice_item
      t.integer :total_amount
      t.integer :invoice_type
      t.references :project

      t.timestamps
    end
  end
end
