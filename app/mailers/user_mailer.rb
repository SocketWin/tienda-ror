class UserMailer < ApplicationMailer
  default from: 'ing.ronaldespinoza@gmail.com'

  def send_compra(user)
    @user = user
    mail(to: @user.email, subject: user.name+', has comprado en La Tienda Virtual', template_name: "compra")
  end
end
