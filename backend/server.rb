require "bundler"
Bundler.require

require "./models/company"
require "./models/employee"

class Server < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :database_file, "config/database.yml"

  get "/email_address" do
    full_name      = params[:full_name]
    company_domain = params[:company_domain]

    "#{full_name}@#{company_domain}"
  end
end
