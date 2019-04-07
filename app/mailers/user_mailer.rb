class UserMailer < ApplicationMailer
  default from: 'From site <hmel.house@yandex.ru>'

  def reservation_email(reservation)
    @reservation = reservation
    @url = 'http://app.hmelhaus.ru'
    mail(to: 'ss48.a@yandex.ru,reservation@hmelhaus.ru', subject: "RESERVATION - #{@url}" )
  end
  def review_email(review)
    @review = review
    @url = 'http://app.hmelhaus.ru'
    mail(to: 'ss48.a@yandex.ru,reservation@hmelhaus.ru', subject: "REVIEW - #{@url}" )
  end
end
