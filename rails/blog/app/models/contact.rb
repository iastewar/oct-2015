class Contact < ActiveRecord::Base
  validates :title, presence: true,
end
