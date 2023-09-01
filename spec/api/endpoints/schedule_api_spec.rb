require 'rails_helper'

describe 'ScheduleApi' do
  context 'when the get endpoint is hit' do
    let(:request) { get '/Schedule/schedule' }

    context 'with one schedule in the database' do
      let!(:todo) { Todo.create!({ name: 'ahh', info: 'ohh' }) }
      let!(:schedule) { Schedule.create!({ todo_id: todo.id, sunday: 1, tuesday: 1}) }

      it 'returns one schedule' do
        request
        expect(JSON.parse(response.body)).to eq schedule
      end

      it 'only has one schedule before and after the response' do
        expect(Schedule.all.count).to eq 1
        request
        expect(Schedule.all.count).to eq 1
      end
    end

    context 'with multiple schedules in the database' do
      let!(:todo_1) { Todo.create!({ name: 'ahh', info: 'ohh' }) }
      let!(:todo_2) { Todo.create!({ name: 'number', info: 'two' }) }
      let!(:schedule_1) { Schedule.create!({ todo_id: todo_1.id, sunday: 1, tuesday: 1}) }
      let!(:schedule_2) { Schedule.create!({ todo_id: todo_2.id, monday: 1, wednesday: 1}) }

      it 'returns two schedule' do
        request
        expect(JSON.parse(response.body)[0]).to eq schedule_1
        expect(JSON.parse(response.body)[1]).to eq schedule_2
      end

      it 'only has one schedule before and after the response' do
        expect(Schedule.all.count).to eq 2
        request
        expect(Schedule.all.count).to eq 2
      end
    end

    context 'when there are no schedules in the database' do
      it 'does not return a schedule' do
        request
        expect(JSON.parse(response.body)).to eq []
      end

      it 'does not create a new schedule' do
        expect(Schedule.all.count).to eq 0
        request
        expect(Schedule.all.count).to eq 0
      end
    end
  end

  context 'when the post endpoint is hit' do
    let(:request) { post '/Schedule/schedule', :params => { todo_id: todo.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 } }
    let(:todo) { Todo.create!({ name: 'ahh', info: 'ohh' }) }

    context 'with no schedules in the database' do
      it 'creates a schedule' do
        expect(Schedule.count).to eq 0
        request
        expect(Schedule.count).to eq 1
      end
    end

    context 'with one schedule in the database' do
      let!(:schedule) { Schedule.create!({ todo_id: todo.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }

      it 'creates a schedule' do
        expect(Schedule.count).to eq 1
        request
        expect(Schedule.count).to eq 2
      end
    end

    context 'with three schedule in the database' do
      let!(:schedule_1) { Schedule.create!({ todo_id: todo.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }
      let!(:schedule_2) { Schedule.create!({ todo_id: todo.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }
      let!(:schedule_3) { Schedule.create!({ todo_id: todo.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }

      it 'creates a schedule' do
        expect(Schedule.count).to eq 3
        request
        expect(Schedule.count).to eq 4
      end
    end

  #   with one schedule in the database
  #   with multiple schedules in the database
  end
end
