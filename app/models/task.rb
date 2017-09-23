class Task < ActiveRecord::Base
  has_many :projects
end