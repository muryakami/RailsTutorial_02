class JournalTask < ApplicationRecord
  belongs_to :journal
  validates :journal_id, presence: true
  validates :detail, presence: true, length: { maximum: 140 }
  validates :time, presence: true, length: { maximum: 1440 }
end
