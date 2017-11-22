require File.expand_path("../../spec_helper.rb", __FILE__)

describe SampleDataHelper do
  let(:json) do
    {
      "Margaret Atwood" => "matwood@penguinrandomhouse.com",
      "Franz Kafka" => "franzkafka@simonandschuster.com"
    }.to_json
  end

  subject { SampleDataHelper.new(json) }

  describe "store_data!" do
    let(:companies) { Company.all }
    let(:employees) { Employee.all }

    before { subject.store_data! }

    it "stores normalized data" do
      expect(companies.map(&:domain_name)).to eq(["penguinrandomhouse.com", "simonandschuster.com"])
      expect(employees.map(&:first_name)).to eq(["Margaret", "Franz"])
      expect(employees.map(&:last_name)).to eq(["Atwood", "Kafka"])
      expect(employees.map(&:email_name)).to eq(["matwood", "franzkafka"])
    end

    context "the JSON is malformed" do
      before { allow(subject).to receive(:sample_data).and_raise(JSON::ParserError) }

      it "raises a custom error" do
        expect { subject.store_data! }.to raise_error(
          SampleDataHelper::MalformedDataError, "The data submitted is not in the correct format."
        )
      end
    end

    context "the keys are not formed correctly" do
      before { allow(subject).to receive(:sample_data).and_raise(NoMethodError) }

      it "raises a custom error" do
        expect { subject.store_data! }.to raise_error(
          SampleDataHelper::MalformedDataError, "The data submitted is not in the correct format."
        )
      end
    end
  end
end
