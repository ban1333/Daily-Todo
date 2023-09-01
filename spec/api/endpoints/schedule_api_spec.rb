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
    let(:request) { post '/Schedule/schedule', :params => desired_fields }
    let(:todo) { Todo.create!({ name: 'ahh', info: 'ohh' }) }
    let(:desired_fields) { { todo_id: todo.id, sunday: true, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true } }

    context 'with no schedules in the database' do
      it 'creates a schedule' do
        expect(Schedule.count).to eq 0
        request
        expect(Schedule.count).to eq 1
      end

      it 'has the desired fields' do
        request
        expect(Schedule.first.todo_id).to eq desired_fields[:todo_id]
        expect(Schedule.first.sunday).to eq desired_fields[:sunday]
        expect(Schedule.first.monday).to eq desired_fields[:monday]
        expect(Schedule.first.tuesday).to eq desired_fields[:tuesday]
        expect(Schedule.first.wednesday).to eq desired_fields[:wednesday]
        expect(Schedule.first.thursday).to eq desired_fields[:thursday]
        expect(Schedule.first.friday).to eq desired_fields[:friday]
        expect(Schedule.first.saturday).to eq desired_fields[:saturday]
      end
    end

    context 'with one schedule in the database' do
      let!(:schedule) { Schedule.create!({ todo_id: todo.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }
      let(:desired_fields) { { todo_id: todo.id, sunday: true, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true } }

      it 'creates a schedule' do
        expect(Schedule.count).to eq 1
        request
        expect(Schedule.count).to eq 2
      end

      it 'has the desired fields' do
        request
        expect(Schedule.last.todo_id).to eq desired_fields[:todo_id]
        expect(Schedule.last.sunday).to eq desired_fields[:sunday]
        expect(Schedule.last.monday).to eq desired_fields[:monday]
        expect(Schedule.last.tuesday).to eq desired_fields[:tuesday]
        expect(Schedule.last.wednesday).to eq desired_fields[:wednesday]
        expect(Schedule.last.thursday).to eq desired_fields[:thursday]
        expect(Schedule.last.friday).to eq desired_fields[:friday]
        expect(Schedule.last.saturday).to eq desired_fields[:saturday]
      end
    end

    context 'with three schedule in the database' do
      let!(:schedule_1) { Schedule.create!({ todo_id: todo.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }
      let!(:schedule_2) { Schedule.create!({ todo_id: todo.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }
      let!(:schedule_3) { Schedule.create!({ todo_id: todo.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }
      let(:desired_fields) { { todo_id: todo.id, sunday: true, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true } }

      it 'creates a schedule' do
        expect(Schedule.count).to eq 3
        request
        expect(Schedule.count).to eq 4
      end

      it 'has the desired fields' do
        request
        expect(Schedule.last.todo_id).to eq desired_fields[:todo_id]
        expect(Schedule.last.sunday).to eq desired_fields[:sunday]
        expect(Schedule.last.monday).to eq desired_fields[:monday]
        expect(Schedule.last.tuesday).to eq desired_fields[:tuesday]
        expect(Schedule.last.wednesday).to eq desired_fields[:wednesday]
        expect(Schedule.last.thursday).to eq desired_fields[:thursday]
        expect(Schedule.last.friday).to eq desired_fields[:friday]
        expect(Schedule.last.saturday).to eq desired_fields[:saturday]
      end
    end

  #   with one schedule in the database
  #   with multiple schedules in the database
  end

  context 'when the put endpoint is hit' do
    let(:request) { put '/Schedule/:id', :params => { schedule: { id: todo.id}, todo_id: todo.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }}

    context 'when there is one schedule in the database' do
      let!(:schedule) { Schedule.create!({ todo_id: todo.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }
      let(:todo) { Todo.create!({ name: 'ooh', info: 'ahh' }) }
      let!(:updated_schedule) {Schedule.new({ todo_id: todo.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 })}

      it 'only has one schedule before and after' do
        expect(Schedule.count).to be 1
        request
        expect(Schedule.count).to be 1
      end

      it 'updates the schedule to the desired fields' do
        request
        expect(Schedule.first.todo_id).to eq updated_schedule.todo_id
        expect(Schedule.first.sunday).to eq updated_schedule.sunday
        expect(Schedule.first.monday).to eq updated_schedule.monday
        expect(Schedule.first.tuesday).to eq updated_schedule.tuesday
        expect(Schedule.first.wednesday).to eq updated_schedule.wednesday
        expect(Schedule.first.thursday).to eq updated_schedule.thursday
        expect(Schedule.first.friday).to eq updated_schedule.friday
        expect(Schedule.first.saturday).to eq updated_schedule.saturday
      end
    end
  end
end
