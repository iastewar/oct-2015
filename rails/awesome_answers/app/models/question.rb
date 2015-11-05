class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy # or nullify - to make all question_id values null (dependent to maintain referential integriry)
  # gives method answers to Question (to create an answer: q.answers.create)

  validates(:title, {presence: true,
                     uniqueness: {message: "was used already"},
                     length: {minimum: 3}})
  validates(:body, presence: true,
                  uniqueness: {scope: :title})
  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  validate :no_monkey

  after_initialize :set_default_values #initialize, validation, save, commit

#  scope :recent_ten, lambda { order("created_at DESC").limit(10) }
#  same as:
  def  self.recent_ten
    order("created_at DESC").limit(10)
  end

  def self.search(string)
    where(["title ILIKE :search_term OR body ILIKE :search_term", {search_term: "%#{string}%"}])
  end

  private

  def no_monkey
    if title.present? && title.downcase.include?("monkey")
      errors.add(:title, "No monkeys please!")
    end
  end

  def set_default_values
    self.view_count ||= 7
  end
end
