class Message < ActiveRecord::Base
	validates :to, :content, presence: true
	validates :to, format: { with: %r{\A((\+61)|0)\d{9}\Z}ix,
													 message: "Please provide a valid Australian number. No spaces." }
end
