require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'scopes' do
    context 'is_today' do
      let!(:todo) { Todo.create!({ name: 'ooh', info: 'ahh' }) }
      let!(:schedules_1) { Schedule.create!({ todo_id: todo.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
      let!(:schedules_2) { Schedule.create!({ todo_id: todo.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
      let!(:schedules_3) { Schedule.create!({ todo_id: todo.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
      let!(:schedules_not_today) { 3.times { Schedule.create!({ todo_id: todo.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) } }

      it 'returns a schedule that is today' do
        expect(Schedule.all_today.count).to be 3
      end
    end
  end
end
