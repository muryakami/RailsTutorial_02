class CreateJournalTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :journal_tasks do |t|
      t.integer :journal_id
      t.integer :task_id

      t.timestamps
    end
    add_index :journal_tasks, :journal_id
    add_index :journal_tasks, :task_id
    add_index :journal_tasks, [:journal_id, :task_id], unique: true
  end
end
