class OrderMailer < ApplicationMailer
  def completed_order(order)
    @order = order
    mail(to: @order.user.email, subject: I18n.t('mailer.order.subject'))
  end
end
