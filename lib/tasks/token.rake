require 'rest-client'

namespace :telstra do
  desc 'Get the access token for Telstra API'
  task :token => :environment do
    telstra_token_url = "https://api.telstra.com/v1/oauth/token?client_id=#{ENV["CLIENT_ID"]}&client_secret=#{ENV["CLIENT_SECRET"]}&grant_type=client_credentials&scope=SMS"
    returned = RestClient.get telstra_token_url
    token = JSON.parse(returned)["access_token"]
    if Token.last
    	recent = Token.last
    	recent.token = token
    	recent.save
    else
    	Token.create(token: token)
    end
  end
end