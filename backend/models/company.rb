class Company < ActiveRecord::Base
  has_many :employees

  def full_names_for_email?
    employees.all? do |employee|
      downcased_full_name(employee) == employee.email_name
    end
  end

  def initialized_first_name_for_email?
    employees.all? do |employee|
      downcased_first_initial_and_last_name(employee) == employee.email_name
    end
  end

  private

  def downcased_full_name(employee)
    "#{employee.first_name.downcase}#{employee.last_name.downcase}"
  end

  def downcased_first_initial_and_last_name(employee)
    "#{employee.first_name.downcase[0]}#{employee.last_name.downcase}"
  end
end
