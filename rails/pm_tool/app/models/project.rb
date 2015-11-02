# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  due_date    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ActiveRecord::Base
#  serialize :task_array, Array
  has_many :tasks, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: true


end
