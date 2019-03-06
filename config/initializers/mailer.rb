ActionMailer::Base.default_url_options = { host: 'localhost', port: 3003 }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :tls => true,
  address: 'smtp.yandex.ru',
  port: 465,
  domain: 'yandex.ru',
  authentication: 'plain',
  user_name: 'hmel.house@yandex.ru',
  password: Rails.application.secrets.yandex_mail
}