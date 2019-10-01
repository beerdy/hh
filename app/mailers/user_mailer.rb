class UserMailer < ApplicationMailer
  default from: 'Хмель Haus <hmel.house@yandex.com>'

  def reservation_email(reservation)
    @reservation = reservation
    @url = 'https://hmelhaus.ru'
    mail(to: 'reservation@hmelhaus.ru,a.kolosova@hmelhaus.ru,ss48.a@yandex.ru,candream@yandex.ru', subject: "Бронирование столика" )
  end
  def review_email(review)
    @review = review
    @url = 'https://hmelhaus.ru'
    mail(to: 'reservation@hmelhaus.ru,a.kolosova@hmelhaus.ru,ss48.a@yandex.ru,candream@yandex.ru', subject: "Отзыв на сайте" )
  end
end
