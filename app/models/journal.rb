class Journal < ApplicationRecord
  belongs_to :user
  has_many :journal_tasks, dependent: :destroy
  has_many :tasks, through: :journal_tasks, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  # タスクを追加する
  def add_task(task)
    tasks << task
  end

  # タスクを削除する
  def remove_task(task)
    journal_tasks.find_by(task_id: task.id).destroy
  end

  # 試作feedの定義
  def feed
      Task.includes(:journals).where("journal_id = ?", id).references(:journals)
  end

end
