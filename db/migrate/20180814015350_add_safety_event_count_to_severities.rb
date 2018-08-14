class AddSafetyEventCountToSeverities < ActiveRecord::Migration[5.0]
  def change
    add_column :severities, :safety_events_count, :integer
  end
end
