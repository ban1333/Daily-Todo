class Todo < ApplicationRecord
  has_one :schedule

  scope :todos_for_today, -> do
    Todo.all
        .joins(:schedule)
      .where(schedules: {:"#{DateTime.now.strftime("%A").downcase}" => true})
  end
end
