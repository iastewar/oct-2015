class User < ActiveRecord::Base
  has_many: :items, dependent: :destroy
  has_secure_password

  validates :email, presence: true, uniqueness: true


end
