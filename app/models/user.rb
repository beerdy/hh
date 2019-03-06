class User
  include Mongoid::Document
  include Mongoid::Paperclip

  #before_save :disable_edit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time


  has_mongoid_attached_file :image  
  has_mongoid_attached_file :image,
    :styles => {
      :thumb => "320x240#",
      :medium => "800x600#"
    }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  field :fio,               type: String, default: ""
  field :hb,                type: String, default: ""
  field :card,              type: String, default: ""
  field :phone,             type: String, default: ""
  field :role,              type: String, default: ""
  field :bonuses,           type: Integer, default: 300
  field :percent,           type: Integer, default: 3

  has_many :reviews, dependent: :destroy
  has_many :reservations, dependent: :destroy


  ## Trackable
  # field :sign_in_count,      type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  #has_one :cart
  def email?(email)
    self.email == email.to_s
  end
  def admin?
    email?('candream@ya.ru') || email?('ss48.a@yandex.ru')
  end

  private
    def convert_title_to_url
      self.url = self.title.to_slug_param if self.url == nil or self.url == ''
    end
end
