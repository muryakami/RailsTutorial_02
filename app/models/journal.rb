class Journal < ApplicationRecord
  belongs_to :user
  has_many :journal_tasks, dependent: :destroy
  has_many :tasks, through: :journal_tasks, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
