class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, allow_blank: true, message: 'には英字と数字の両方を含めて設定してください'
  with_options presence: true do
    validates :nickname
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]/, allow_blank: true, message: "全角カタカナで入力して下さい" }
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]/, allow_blank: true, message: "全角カタカナで入力して下さい" }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, allow_blank: true, message: "全角カタカナで入力して下さい" }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, allow_blank: true, message: "全角カタカナで入力して下さい" }
    validates :birthday
  end
  
end

