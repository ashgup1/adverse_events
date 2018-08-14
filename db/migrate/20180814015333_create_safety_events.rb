class CreateSafetyEvents < ActiveRecord::Migration
  def change
    create_table :safety_events do |t|
      t.text :comment
      t.integer :classification_id
      t.integer :user_id
      t.text :root_cause
      t.text :action_plan

      t.timestamps

    end
  end
end
