require "bundler"
Bundler.require :default

describe Array do
  before do
    @strings = %w[foo bar]
  end

  it "returns a new array" do
    @strings.map(&:upcase).should == %w[FOO BAR]
  end

  it "return an array" do
    "test".split("").should == %w[t e s t]
  end

  it "used to convert an string to array" do
    "test".to_a.should == %w[t e s t]
  end
end
