TaxCloud.configure do |config|
  config.api_login_id = ENV['TAXCOLUD_API_ID']
  config.api_key = ENV['TAXCLOUD_API_KEY']
  config.usps_username = ENV['USPS_USERNAME']
end
