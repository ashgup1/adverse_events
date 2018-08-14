class AddSafetyEventCountToClassifications < ActiveRecord::Migration[5.0]
  def change
    add_column :classifications, :safety_events_count, :integer
  end
end
