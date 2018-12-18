class Task < ApplicationRecord
  has_many :journal_tasks
  has_many :journals, through: :journal_tasks
  validates :time, presence: true, length: { maximum: 1440 }
  validates :detail, length: { maximum: 140 }
end
