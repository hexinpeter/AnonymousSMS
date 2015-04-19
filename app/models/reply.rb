class Reply
	attr_accessor :from, :acknowledgedTimestamp, :content

	def initialize(from, acknowledgedTimestamp, content)
		@from = from
		@acknowledgedTimestamp = acknowledgedTimestamp
		@content = content
	end
end