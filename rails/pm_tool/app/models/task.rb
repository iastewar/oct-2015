class Task < ActiveRecord::Base

  validates :title, presence: true,
                    uniqueness: {scope: :project}
  validates :project, presence: true

end
