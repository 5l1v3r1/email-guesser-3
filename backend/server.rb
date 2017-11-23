require "bundler"
Bundler.require

require "./models/company"
require "./models/employee"
require "./lib/sample_data_helper"
require "./lib/email_address_finder"

class Server < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :database_file, "config/database.yml"
  set :bind, "0.0.0.0"

  configure do
    enable :cross_origin
  end

  before do
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Credentials"] = "true"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token, access-control-allow-origin"
    response.headers["Access-Control-Allow-Origin"] = "http://localhost:3030"
  end

  options "*" do
    200
  end

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
