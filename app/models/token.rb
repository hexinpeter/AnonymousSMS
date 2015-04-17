class Token < ActiveRecord::Base
	def self.get_token
		if !Token.last || (Token.last.updated_at + 50.minutes < Time.now)
			Token.generate_token
		end
		Token.last.token
	end

	def self.generate_token
		telstra_token_url = "https://api.telstra.com/v1/oauth/token?client_id=#{ENV["CLIENT_ID"]}&client_secret=#{ENV["CLIENT_SECRET"]}&grant_type=client_credentials&scope=SMS"
    returned = RestClient.get telstra_token_url
    token = JSON.parse(returned)["access_token"]
    if Token.last
    	recent = Token.lock(true).last
    	recent.token = token
    	recent.save
    else
    	Token.lock(true).create(token: token)
    end
	end
end
