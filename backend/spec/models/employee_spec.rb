require File.expand_path("../../spec_helper.rb", __FILE__)

describe Employee, type: :model do
  it { should belong_to :company }
end
