class Comment < ActiveRecord::Base
  belongs_to :item # gives the Answer class the question method to find or set a question for an answer

  validates :body, presence: true,
                   uniqueness: {scope: :item}
end
