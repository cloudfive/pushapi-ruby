require 'spec_helper'

describe CloudFivePush::Notification do
  before(:all) { CloudFivePush.api_key = "fake" }
  context "Setting user identifiers" do 
    let(:notification) { CloudFivePush::Notification.new }
    it "accepts an array of identifiers" do 
      notification.user_identifiers = [1,2,3]
      expect(notification.user_identifiers).to eq [1,2,3]
    end

    it "accepts a single user_identifier" do 
      notification.user_identifiers = 1
      expect(notification.user_identifiers).to eq [1]
    end
  end

end