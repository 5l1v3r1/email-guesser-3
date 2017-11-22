class SampleDataHelper
  def initialize(json)
    @json = json
  end

  def store_data!
    sample_data.each do |full_name, email|
      email_names = email_names(email)
      names = names(full_name)
      company = Company.find_or_create_by(domain_name: email_names.last)
      Employee.find_or_create_by(
        company: company,
        email_name: email_names.first,
        first_name: names.first,
        last_name: names.last
      )
    end
  end

  private

  attr_reader :json

  def email_names(email)
    email.split("@")
  end

  def names(full_name)
    full_name.split(" ")
  end

  def sample_data
    @sample_data ||= JSON.parse(json)
  end
end
