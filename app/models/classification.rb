class Classification < ApplicationRecord
  # Direct associations

  has_many   :safety_events,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
