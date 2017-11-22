require File.expand_path("../../spec_helper.rb", __FILE__)

describe EmailAddressFinder do
  let(:params) { { "full_name" => "foo", "company_domain" => "foo.com" } }
  let(:names) { ["frida", "kahlo"] }
  let(:company_domain) { "babbel.com" }

  subject { EmailAddressFinder.new(params) }

  before do 
    allow(subject).to receive(:company).and_return(company)
    allow(subject).to receive(:names).and_return(names)
    allow(subject).to receive(:company_domain).and_return(company_domain)
  end

  describe "guess" do
    context "employees' names are full on email" do
      let(:company) { instance_double(Company, full_names_for_email?: true) }

      it "returns the formatted email" do
        expect(subject.guess).to eq("fridakahlo@babbel.com")
      end
    end

    context "employees' first name is initialized on email" do
      let(:company) do 
        instance_double(Company, full_names_for_email?: false, initialized_first_name_for_email?: true)
      end

      it "returns the formatted email" do
        expect(subject.guess).to eq("fkahlo@babbel.com")
      end
    end

    context "the company is unrecognized" do
      let(:company) { nil }

      it "raises an error" do
        expect { subject.guess }.to raise_error(
          described_class::UnrecognizedCompanyError, "That company domain is not recognized."
        )
      end
    end

    context "the format is inconclusive" do
      let(:company) do 
        instance_double(Company, full_names_for_email?: false, initialized_first_name_for_email?: false)
      end

      it "raises an error" do
        expect { subject.guess }.to raise_error(
          described_class::InconclusiveFormatError, "The email format for the company is inconclusive."
        )
      end
    end
  end
end
