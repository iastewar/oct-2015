class Project < ActiveRecord::Base
#  serialize :task_array, Array

  validates :title, presence: true,
                    uniqueness: true


end
