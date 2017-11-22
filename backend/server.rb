require "bundler"
Bundler.require

require "./models/company"
require "./models/employee"
require "./lib/sample_data_helper"
require "./lib/email_address_finder"

class Server < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :database_file, "config/database.yml"

  post "/sample_data" do
    content_type :json

    begin
      SampleDataHelper.new(params[:sample_data]).store_data!
      { success_message: "The data was stored." }.to_json
    rescue SampleDataHelper::MalformedDataError => e
      { error_message: e }.to_json
    end
  end

  get "/email_address" do
    content_type :json

    begin
      finder = EmailAddressFinder.new(params)
      { email_address: finder.guess }.to_json
    rescue EmailAddressFinder::UnrecognizedCompanyError, EmailAddressFinder::InconclusiveFormatError => e
      { error_message: e }.to_json
    end
  end
end
