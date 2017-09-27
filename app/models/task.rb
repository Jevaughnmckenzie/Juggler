class Task < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true
  validates :time_allocation, presence: true
end