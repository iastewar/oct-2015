class User < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  has_secure_password
  validates :email, presence: true, uniqueness: true
end
