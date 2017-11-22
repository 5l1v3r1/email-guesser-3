require File.expand_path("../spec_helper.rb", __FILE__)

describe Company do
  let(:sample_data) { File.read("./mocks/sample-data.json") }

  describe "POST /sample_data" do
    it "stores the sample data" do
      post "/sample_data", { sample_data: sample_data }
      expect(last_response.body).to eq(
        { success_message: "The data was stored." }.to_json
      )
    end

    context "the sample data is malformed" do
      let(:sample_data) { "".to_json }

      it "returns an error message" do
        post "/sample_data", { sample_data: sample_data }
        expect(last_response.body).to eq(
          { error_message: "The data submitted is not in the correct format." }.to_json
        )
      end
    end
  end

  describe "GET /email_address" do
    before { SampleDataHelper.new(sample_data).store_data! }

    it "returns a formatted email address" do
      get "/email_address?full_name=Josephine+Wright&company_domain=babbel.com"
      expect(last_response.body).to eq(
        { email_address: "jwright@babbel.com" }.to_json
      )
    end

    context "the company domain is unrecognized" do
      it "returns an error message" do
        get "/email_address?full_name=foo&company_domain=foo.com"
        expect(last_response.body).to eq(
          { error_message: "That company domain is not recognized." }.to_json
        )
      end
    end

    context "the email address does not have a conclusive format" do
      let(:sample_data) do 
        { "John Doe" => "jdoe@babbel.com", "Jane Doe" => "janedoe@babbel.com" }.to_json
      end

      it "returns an error message" do
        get "/email_address?full_name=Peter+Pan&company_domain=babbel.com"
        expect(last_response.body).to eq(
          { error_message: "The email format for the company is inconclusive." }.to_json
        )
      end
    end
  end
end
