class CreateQboCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :qbo_customers, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :display_name
      t.string :email
      t.string :phone_number
      t.string :notes
      t.jsonb :additional_data

      t.timestamps
    end
  end
end
