class SafetyEvent < ApplicationRecord
  # Direct associations

  belongs_to :classification,
             :counter_cache => true

  belongs_to :user

  # Indirect associations

  # Validations

end
