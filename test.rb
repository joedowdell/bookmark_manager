require 'rest_client'

def send_password_reset(email)

RestClient.post "https://api:key-94e5805225a1d51f1749d853ec3ec27f"\
  "@api.mailgun.net/v2/sandbox09032655beb7405b998fde40c819fe70.mailgun.org/messages",
  	from: "Mailgun Sandbox <postmaster@sandbox09032655beb7405b998fde40c819fe70.mailgun.org>",
		to: email,
		subject: "Your reset password link",
		text: "user.password_token"
	end

	send_password_reset("joedowdell@gmail.com")