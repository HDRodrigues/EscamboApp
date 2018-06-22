class AdminMailerPreview < ActionMailer::Preview
	def update_email
		#Esta chamando a classe AdminMailer para o envio do email(app/mailer)
		AdminMailer.update_email(Admin.first,Admin.last)
	end

	def send_message
		AdminMailer.send_message(Admin.first, Admin.last.email,"Subject Test","Test Message")
	end
end