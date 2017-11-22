class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.references :company, index: true, foreign_key: true
      t.string :full_name, null: false
      t.string :email_name, null: false
      t.timestamps
    end
  end
end
