require 'spec_helper'

describe CloudFivePush::Notification do
  before(:all) { CloudFivePush.api_key = "fake"; }
  let(:notification) { CloudFivePush::Notification.new }
  context "Setting user identifiers" do
    it "accepts an array of identifiers" do
      notification.user_identifiers = [1,2,3]
      expect(notification.user_identifiers).to eq [1,2,3]
    end

    it "accepts a single user_identifier" do
      notification.user_identifiers = 1
      expect(notification.user_identifiers).to eq [1]
    end
  end


  it "Uses the global aps_environment setting" do
    CloudFivePush.aps_environment = :development
    expect(notification.aps_environment).to eq :development
    CloudFivePush.aps_environment = nil #reset
  end

end