class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :domain_name, null: false
      t.timestamps
    end
  end
end
