class SendWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(id)
		token = Token.get_token
		header =  {authorization: "Bearer #{token}", "Content-Type" => "application/json", "Accept" => "application/json"}
		message = Message.find(id)
    mid = RestClient.post "https://api.telstra.com/v1/sms/messages", {to: message.to, body: message.content}.to_json, header
    message.mid = JSON.parse(mid)["messageId"] if mid
    message.save!
	end
end