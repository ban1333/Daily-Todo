class Schedule < ApplicationRecord
  belongs_to :todo

  scope :all_today, -> do
    thingy = DateTime.now.strftime("%A").downcase.to_sym
    where(:"#{DateTime.now.strftime("%A").downcase}" => true)
  end
end
