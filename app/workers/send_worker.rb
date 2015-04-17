class SendWorker
	include Sidekiq::Worker

	def perform(token, to, content)
		header =  {authorization: "Bearer #{token}", "Content-Type" => "application/json", "Accept" => "application/json"}
    RestClient.post "https://api.telstra.com/v1/sms/messages", {to: to, body: content}.to_json, header
	end
end