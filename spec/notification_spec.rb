require 'spec_helper'

RSpec.describe CloudFivePush::Notification do
  before(:all) { CloudFivePush.api_key = "fake" }

  let(:notification) { CloudFivePush::Notification.new }

  describe '::new' do
    it 'sets broadcast to false' do
      expect(notification.broadcast).to eq false
    end

    it 'sets user identifiers to blank array' do
      expect(notification.user_identifiers).to eq []
    end

    it 'sets the aps_environment from CloudFivePush' do
      CloudFivePush.aps_environment = 'production'
      expect(notification.aps_environment).to eq 'production'
    end

    it 'raises error if there is no api_key' do
      CloudFivePush.api_key = nil
      expect {
        notification
      }.to raise_error "api_key is required. Pass into initializer or set CloudFivePush.api_key first"
      CloudFivePush.api_key = 'fake'
    end
  end

  describe '#notify!' do
    it 'posts to the cloud five api url and returns our json' do
      notification.broadcast = true
      expect(notification.notify!).to eq({
         "success"=>false,
         "error"=>"Invalid API key"
      })
    end

    it 'raises error if broadcast is false and there are no user identifiers' do
      expect{
        notification.notify!
      }.to raise_error "Please set user_identifiers or set broadcast=true"
    end

    it 'raises error if broadcast is true and there are user identifiers' do
      notification.broadcast = true
      notification.user_identifiers = [1]
      expect{
        notification.notify!
      }.to raise_error "Can't both broadcast and set user_identifiers"
    end
  end

  describe "#user_identifiers=" do
    it "accepts an array of identifiers" do
      notification.user_identifiers = [1,2,3]
      expect(notification.user_identifiers).to eq [1,2,3]
    end

    it "accepts a single user_identifier" do
      notification.user_identifiers = 1
      expect(notification.user_identifiers).to eq [1]
    end
  end

  describe '#user_identifier=' do
    it 'is an alias to user_identifiers=' do
      notification.user_identifier = 1
      expect(notification.user_identifiers).to eq [1]
    end
  end
end
