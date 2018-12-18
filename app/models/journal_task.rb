class JournalTask < ApplicationRecord
  belongs_to :journal
  belongs_to :task
  validates :journal_id, presence: true
end
