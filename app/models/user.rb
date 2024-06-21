class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases

  validates :nickname, presence: true
  validates :birthdate, presence: true
  validates :password,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d).{6,}\z/, message: 'is invalid. Include both letters and numbers' }
  validates :last_name, presence: true, format: { with: /\A[^ -~｡-ﾟ]+\z/, message: 'is invalid. Input full-width characters' }
  validates :first_name, presence: true, format: { with: /\A[^ -~｡-ﾟ]+\z/, message: 'is invalid. Input full-width characters' }
  validates :last_kananame, presence: true,
                            format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :first_kananame, presence: true,
                             format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
end
