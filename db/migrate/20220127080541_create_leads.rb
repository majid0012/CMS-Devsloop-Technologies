class CreateLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :leads do |t|
      t.string :title
      t.string :company_name
      t.string :company_address
      t.string :email_address
      t.string :phone_number

      t.timestamps
    end
  end
end
