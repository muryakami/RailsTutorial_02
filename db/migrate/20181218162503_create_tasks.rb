class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.integer :time
      t.text :detail

      t.timestamps
    end
  end
end
