module ReplyHelper
	extend ActiveSupport::Concern

	# return an array of Reply objects
	def get_reply(mid)
		if !mid
			return
		end
		token = Token.get_token
		header =  {authorization: "Bearer #{token}", "Content-Type" => "application/json", "Accept" => "application/json"}
		result = RestClient.get "https://api.telstra.com/v1/sms/messages/#{mid}/response", header
		result = JSON.parse(result)
		reply = []
		result.each do |r|
			reply.push Reply.new(r['from'], r['acknowledgedTimestamp'], r['content'])
		end
		reply
	end
end