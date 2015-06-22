require 'vcr'

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = File.join __dir__, '../vcr_cassettes'
  config.configure_rspec_metadata!
  config.hook_into :webmock
  config.ignore_localhost = true
end

RSpec.configure do |config|
  config.around :each do |example|
    # VCR won't create cassettes for examples that do not make requests
    # so set the vcr metadata for every example
    # so VCR is invoked automagically for every test that makes external requests
    example.metadata[:vcr] = true
    example.run
  end
end
