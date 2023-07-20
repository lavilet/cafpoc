class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :api_key

      t.timestamps
    end
  end
end
