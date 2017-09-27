class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks

  validates :name, presence: true
  validates :active_status, presence: true
end