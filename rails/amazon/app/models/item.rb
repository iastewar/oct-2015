class Item < ActiveRecord::Base
  has_many :answers, dependent: :destroy # or nullify - to make all question_id values null (dependent to maintain referential integriry)

  belongs_to: user

  validates :title, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}

end
