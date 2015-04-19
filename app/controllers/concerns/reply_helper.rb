module ReplyHelper
	extend ActiveSupport::Concern

	def get_reply(mid)
		if !mid
			return
		end
		token = Token.get_token
		header =  {authorization: "Bearer #{token}", "Content-Type" => "application/json", "Accept" => "application/json"}
		result = RestClient.get "https://api.telstra.com/v1/sms/messages/#{mid}/response", header
		result = JSON.parse(result)[0]
		reply = Reply.new(result['from'], result['acknowledgedTimestamp'], result['content'])
	end
end