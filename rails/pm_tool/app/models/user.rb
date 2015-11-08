class User < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tasks, dependent: :destroy

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
