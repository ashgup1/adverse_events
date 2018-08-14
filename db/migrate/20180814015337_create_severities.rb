class CreateSeverities < ActiveRecord::Migration
  def change
    create_table :severities do |t|
      t.integer :event_id

      t.timestamps

    end
  end
end
