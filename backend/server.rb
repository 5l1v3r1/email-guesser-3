require "sinatra"
require "sinatra/activerecord"
require "json"
require "pry"

class Server < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :database_file, "config/database.yml"

  get "/" do
    content_type :json

    { "foo" => "bar" }.to_json
  end
end
