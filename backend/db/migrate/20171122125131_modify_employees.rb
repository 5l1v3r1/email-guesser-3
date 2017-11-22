class ModifyEmployees < ActiveRecord::Migration[5.1]
  def change
    remove_column :employees, :full_name
    add_column :employees, :first_name, :string
    add_column :employees, :last_name, :string
  end
end
