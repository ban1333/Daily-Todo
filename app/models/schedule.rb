class Schedule < ApplicationRecord
  belongs_to :todo

  attr_accessor :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday
end
