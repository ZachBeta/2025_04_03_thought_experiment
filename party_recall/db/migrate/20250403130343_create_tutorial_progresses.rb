class CreateTutorialProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :tutorial_progresses do |t|
      t.string :current_stage, null: false
      t.json :completed_steps, null: false, default: {}
      t.string :session_id, null: false

      t.timestamps

      t.index :session_id, unique: true
      t.index :current_stage
    end
  end
end
