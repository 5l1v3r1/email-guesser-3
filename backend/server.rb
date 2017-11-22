require "bundler"
Bundler.require

require "./models/company"
require "./models/employee"
require "./lib/sample_data_helper"

class Server < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :database_file, "config/database.yml"

  post "/sample_data" do
    SampleDataHelper.new(params).store!
  end

  get "/email_address" do
    full_name      = params[:full_name]
    company_domain = params[:company_domain]

    "#{full_name}@#{company_domain}"
  end
end
