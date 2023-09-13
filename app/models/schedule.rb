class Schedule < ApplicationRecord
  belongs_to :todo, optional: true
end
