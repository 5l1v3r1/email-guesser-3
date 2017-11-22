require_relative "../server"

json = File.read("./mocks/sample-data.json")
SampleDataHelper.new(json).store_data!
