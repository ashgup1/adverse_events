class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.integer :event_id

      t.timestamps

    end
  end
end
