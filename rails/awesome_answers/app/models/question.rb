class Question < ActiveRecord::Base

  validates(:title, {presence: true,
                     uniqueness: {message: "was used already"},
                     length: {minimum: 3}})
  validates(:body, presence: true,
                  uniqueness: {scope: :title})
  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  validate :no_monkey

  after_initialize :set_default_values

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
