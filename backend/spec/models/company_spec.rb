require File.expand_path("../../spec_helper.rb", __FILE__)

describe Company, type: :model do
  subject { Company.create(domain_name: "foo.com") }
  let(:first_employee) do
    Employee.create(
      company: subject,
      first_name: "Margaret",
      last_name: "Atwood",
      email_name: first_email_name
    )
  end
  let(:second_employee) do
    Employee.create(
      company: subject,
      first_name: "Franz",
      last_name: "Kafka",
      email_name: second_email_name
    )
  end

  it { should have_many :employees }

  describe "full_names_for_email?" do
    before(:each) do
      first_employee
      second_employee
    end

    context "employees' names are full on email" do
      let(:first_email_name) { "margaretatwood" }
      let(:second_email_name) { "franzkafka" }

      it "returns true" do
        expect(subject.full_names_for_email?).to eq(true)
      end
    end

    context "employees' names are not full on email" do
      let(:first_email_name) { "matwood" }
      let(:second_email_name) { "fkafka" }

      it "returns false" do
        expect(subject.full_names_for_email?).to eq(false)
      end
    end

    context "some employees' names are full on email, others not" do
      let(:first_email_name) { "matwood" }
      let(:second_email_name) { "franzkafka" }

      it "returns false" do
        expect(subject.full_names_for_email?).to eq(false)
      end
    end
  end

  describe "initialized_first_name_for_email?" do
    before(:each) do
      first_employee
      second_employee
    end

    context "employees' names are full on email" do
      let(:first_email_name) { "margaretatwood" }
      let(:second_email_name) { "franzkafka" }

      it "returns false" do
        expect(subject.initialized_first_name_for_email?).to eq(false)
      end
    end

    context "employees' names are not full on email" do
      let(:first_email_name) { "matwood" }
      let(:second_email_name) { "fkafka" }

      it "returns true" do
        expect(subject.initialized_first_name_for_email?).to eq(true)
      end
    end

    context "some employees' names are full on email, others not" do
      let(:first_email_name) { "matwood" }
      let(:second_email_name) { "franzkafka" }

      it "returns false" do
        expect(subject.full_names_for_email?).to eq(false)
      end
    end
  end
end
