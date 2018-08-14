class Severity < ApplicationRecord
  # Direct associations

  has_many   :safety_events,
             :foreign_key => "classification_id",
             :dependent => :destroy

  # Indirect associations

  # Validations

end
