class Answer < ActiveRecord::Base
  belongs_to :question # gives the Answer class the question method to find or set a question for an answer

  validates :body, presence: true,
                   uniqueness: {scope: :question}
end
