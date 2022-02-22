class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, allow_blank: true, message: 'は英字と数字の両方を含めて設定してください'
  with_options presence: true do
    validates :nickname
    validates :first_name
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]/, allow_blank: true, message: 'は全角で入力してください' } do
      validates :first_name
      validates :last_name
    end
    with_options format: { with: /\A[ァ-ヶー]+\z/, allow_blank: true, message: 'は全角カタカナで入力してください' } do
      validates :first_name_kana
      validates :last_name_kana
    end
    validates :birthday
  end

  has_many :items
  has_many :order
end
