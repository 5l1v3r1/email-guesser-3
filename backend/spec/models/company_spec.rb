require File.expand_path("../../spec_helper.rb", __FILE__)

describe Company, type: :model do
  it { should have_many :employees }
end
