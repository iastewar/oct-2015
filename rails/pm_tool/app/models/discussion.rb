# == Schema Information
#
# Table name: discussions
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Discussion < ActiveRecord::Base
  validates :title, presence: true

end
