class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, allow_blank: true, message: 'is invalid. Include both letters and numbers'
  with_options presence: true do
    validates :nickname
    validates :first_name,
              format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]/, allow_blank: true, message: 'is invalid. Input full-width characters' }
    validates :last_name,
              format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]/, allow_blank: true, message: 'is invalid. Input full-width characters' }
    validates :first_name_kana,
              format: { with: /\A[ァ-ヶー]+\z/, allow_blank: true, message: 'is invalid. Input full-width katakana characters' }
    validates :last_name_kana,
              format: { with: /\A[ァ-ヶー]+\z/, allow_blank: true, message: 'is invalid. Input full-width katakana characters' }
    validates :birthday
  end

  has_many :items
  has_many :order
end
