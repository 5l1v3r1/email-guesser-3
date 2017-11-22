class EmailAddressFinder
  class UnrecognizedCompanyError < StandardError; end
  class InconclusiveFormatError < StandardError; end

  def initialize(params)
    @params = params
  end

  def guess
    raise UnrecognizedCompanyError, "That company domain is not recognized." unless company

    return "#{names.first}#{names.last}@#{company_domain}" if company.full_names_for_email?
    return "#{names.first[0]}#{names.last}@#{company_domain}" if company.initialized_first_name_for_email?

    raise InconclusiveFormatError, "The email format for the company is inconclusive."
  end

  private

  attr_reader :params

  def names
    @names ||= lowercase_full_name.split(" ")
  end

  def company
    @company ||= Company.find_by(domain_name: company_domain)
  end

  def company_domain
    @company_domain ||= params[:company_domain]
  end

  def lowercase_full_name
    @lowercase_full_name ||= params[:full_name].downcase
  end
end
