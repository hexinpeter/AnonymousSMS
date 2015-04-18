class SendWorker
	include Sidekiq::Worker

	def perform(token, id)
		header =  {authorization: "Bearer #{token}", "Content-Type" => "application/json", "Accept" => "application/json"}
		message = Message.find(id)
		to = message.to
		content = message.content
    RestClient.post "https://api.telstra.com/v1/sms/messages", {to: to, body: content}.to_json, header
	end
end