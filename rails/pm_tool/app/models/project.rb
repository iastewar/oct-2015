class Project < ActiveRecord::Base
#  serialize :task_array, Array
#  has_many :tasks, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: true


end
