require 'bcrypt'

class User

	include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password 

	property :id, Serial
	property :email, String, :unique => true, :message => "This email is already taken"
	property :password_digest,          Text
	property :password_token,           Text
	property :password_token_timestamp, Time

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(:email => email)
		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end

	def self.generate_token(email)
		user = first(:email => email)
		user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
    user.password_token_timestamp = Time.now
    user.save
	end

	def send_password_reset
		RestClient.post "https://api:key-94e5805225a1d51f1749d853ec3ec27f"\
  	"@api.mailgun.net/v2/sandbox09032655beb7405b998fde40c819fe70.mailgun.org/messages",
  	from: "Mailgun Sandbox <postmaster@sandbox09032655beb7405b998fde40c819fe70.mailgun.org>",
		to: self.email,
		subject: "Your reset password link",
		text: "http://localhost:9292/users/reset_password/#{self.password_token}"
	end


end