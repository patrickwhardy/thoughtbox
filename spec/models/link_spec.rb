require 'rails_helper'

RSpec.describe Link, type: :model do
  it {should validate_presence_of :title}
  it {should validate_presence_of :url}
  it {should belong_to :user}

  it "has default value for read of false" do
    link = Link.new(title: "Google", url: "http://www.google.com")
    expect(link.read).to be false
  end

  it "validates urls" do
    link = Link.new(title: "Hi", url: "")
    expect(link.valid?).to be false
  end
end
