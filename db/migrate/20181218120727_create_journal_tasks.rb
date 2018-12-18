class CreateJournalTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :journal_tasks do |t|
      t.integer :task_id
      t.text :detail
      t.integer :time
      t.references :journal, foreign_key: true

      t.timestamps
    end
  end
end
