class UserMailer < ApplicationMailer
  # default from: 'notifications@example.com'

  def email(user)
    @user = user
    mail(to: @user.email, subject: 'Título de correo')
  end
end
