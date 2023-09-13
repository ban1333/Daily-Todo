require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'scopes' do
    context 'is_today' do
      let(:todo_1) { Todo.create!({ name: 'one', info: 'ahh' }) }
      let(:todo_2) { Todo.create!({ name: 'two', info: 'ahh' }) }
      let(:todo_3) { Todo.create!({ name: 'three', info: 'ahh' }) }
      let(:todo_4) { Todo.create!({ name: 'four', info: 'ahh' }) }
      let(:todo_5) { Todo.create!({ name: 'five', info: 'ahh' }) }
      let(:todo_6) { Todo.create!({ name: 'six', info: 'ahh' }) }
      let!(:schedule_1) { Schedule.create!({ todo_id: todo_1.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
      let!(:schedule_2) { Schedule.create!({ todo_id: todo_2.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
      let!(:schedule_3) { Schedule.create!({ todo_id: todo_3.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
      let!(:schedule_not_today_1) { Schedule.create!({ todo_id: todo_4.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }
      let!(:schedule_not_today_2) { Schedule.create!({ todo_id: todo_5.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }
      let!(:schedule_not_today_3) { Schedule.create!({ todo_id: todo_6.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }

      it 'returns a schedule that is today' do
        expect(Todo.todos_for_today.count).to be 3
        expect(Schedule.first.todo_id).to eq schedule_1.todo_id
        expect(Schedule.second.todo_id).to eq schedule_2.todo_id
        expect(Schedule.third.todo_id).to eq schedule_3.todo_id
      end
    end
  end
end
