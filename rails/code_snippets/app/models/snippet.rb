class Snippet < ActiveRecord::Base
  validates :kind, presence: true
  validates :title, presence: true, uniqueness: {scope: :kind}

end
