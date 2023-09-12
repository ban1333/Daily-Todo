require 'rails_helper'

describe 'CompletedsApi' do
  context 'when the get endpoint is hit with empty params' do
    let(:request) { get '/Completed/completed' }

    context 'when there are no completed in the database' do
      it 'returns 200 status code' do
        expect(request).to eq 200
      end

      it 'returns nil' do
        request
        expect(JSON.parse(response.body)[0]).to eq nil
      end
    end

    context 'when there is one completed in the database' do
      let(:todo) { Todo.create!({ name: 'ahh', info: 'ohh' }) }
      let!(:completed) { Completed.create!({ date_completed: Date.today, todo_id: todo.id }) }

      it 'returns 200 status code' do
        expect(request).to eq 200
      end

      it 'returns one completed' do
        request
        expect(JSON.parse(response.body)[0]).to eq completed
      end
    end

    context 'when there are multiple completed in the database' do
      let(:todo) { Todo.create!({ name: 'ahh', info: 'ohh' }) }
      let!(:completed_1) { Completed.create!({ date_completed: Date.today, todo_id: todo.id }) }
      let!(:completed_2) { Completed.create!({ date_completed: Date.yesterday, todo_id: todo.id }) }
      let!(:completed_3) { Completed.create!({ date_completed: Date.tomorrow, todo_id: todo.id }) }

      it 'returns 200 status code' do
        expect(request).to eq 200
      end

      it 'returns three completed' do
        request
        expect(JSON.parse(response.body).count).to eq 3
        expect(JSON.parse(response.body).count).to eq Completed.all.count
      end

      it 'returns the correct completed' do
        request
        expect(JSON.parse(response.body)[0]).to eq completed_1
        expect(JSON.parse(response.body)[1]).to eq completed_2
        expect(JSON.parse(response.body)[2]).to eq completed_3
      end
    end
  end

  context 'when the get endpoint is hit with specific params' do
    let(:request) { get '/Completed/completed', :params => { id: todo.id } }
    let(:todo) { Todo.create!({ name: 'ooh', info: 'aah' }) }

    context 'when there are no completed in the database' do
      it 'returns 200 status code' do
        expect(request).to eq 200
      end

      it 'returns nil' do
        request
        expect(JSON.parse(response.body)[0]).to eq nil
      end
    end

    context 'when there are no completed in the database relating to the todo passed' do
      it 'returns 200 status code' do
        expect(request).to eq 200
      end

      it 'returns nil' do
        request
        expect(JSON.parse(response.body)[0]).to eq nil
      end
    end

    context 'when there is one completed in the database' do
      let(:todo) { Todo.create!({ name: 'ahh', info: 'ohh' }) }
      let!(:completed) { Completed.create!({ date_completed: Date.today, todo_id: todo.id }) }

      it 'returns 200 status code' do
        expect(request).to eq 200
      end

      it 'returns one completed' do
        request
        expect(JSON.parse(response.body)[0]).to eq completed
      end
    end

    context 'when there are multiple completed in the database' do
      let(:todo) { Todo.create!({ name: 'ahh', info: 'ohh' }) }
      let!(:completed_1) { Completed.create!({ date_completed: Date.today, todo_id: todo.id }) }
      let!(:completed_2) { Completed.create!({ date_completed: Date.yesterday, todo_id: todo.id }) }
      let!(:completed_3) { Completed.create!({ date_completed: Date.tomorrow, todo_id: todo.id }) }

      it 'returns 200 status code' do
        expect(request).to eq 200
      end

      it 'returns three completed' do
        request
        expect(JSON.parse(response.body).count).to eq 3
        expect(JSON.parse(response.body).count).to eq Completed.all.count
      end

      it 'returns the correct completed' do
        request
        expect(JSON.parse(response.body)[0]).to eq completed_1
        expect(JSON.parse(response.body)[1]).to eq completed_2
        expect(JSON.parse(response.body)[2]).to eq completed_3
      end
    end
  end

  context 'when the post endpoint is hit' do
    let(:request) { post '/Completed/completed', :params => desired_fields }
    let(:todo) { Todo.create!({ name: 'ahh', info: 'ohh' }) }
    let(:utc) { DateTime.now }
    let(:est) { utc.in_time_zone('Eastern Time (US & Canada)') }
    let(:desired_fields) { { date_completed: utc, todo_id: todo.id  } }

    context 'with no completeds in the database' do
      it 'creates a completed' do
        expect(Completed.count).to eq 0
        request
        expect(Completed.count).to eq 1
      end

      it 'has the desired fields' do
        request
        expect(Completed.first.todo_id).to eq desired_fields[:todo_id]
        expect(Completed.first.date_completed).to eq utc.to_fs(:iso8601)
      end
    end

    context 'with one completed in the database' do
      let!(:completed) { Completed.create!({ todo_id: todo.id, date_completed: DateTime.now }) }

      it 'creates a completed' do
        expect(Completed.count).to eq 1
        request
        expect(Completed.count).to eq 2
      end

      it 'has the desired fields' do
        request
        expect(Completed.last.todo_id).to eq desired_fields[:todo_id]
        expect(Completed.last.date_completed).to eq utc.to_fs(:iso8601)
      end
    end

    context 'with three completed in the database' do
      let!(:completed) { Completed.create!({ todo_id: todo.id, date_completed: DateTime.now }) }
      let!(:completed) { Completed.create!({ todo_id: todo.id, date_completed: DateTime.now }) }
      let!(:completed) { Completed.create!({ todo_id: todo.id, date_completed: DateTime.now }) }

      it 'creates a completed' do
        expect(Completed.count).to eq 1
        request
        expect(Completed.count).to eq 2
      end

      it 'has the desired fields' do
        request
        expect(Completed.last.todo_id).to eq desired_fields[:todo_id]
        expect(Completed.last.date_completed).to eq utc.to_fs(:iso8601)
      end
    end
  end

  context 'when the put endpoint is hit' do
    #let(:request) { put '/Completed/:id', :params => { completed: { id: completed.id, date_completed: updated_completed.date_completed } } }
    let(:request) { put '/Completed/:id', :params => { completed: { id: completed.id}, date_completed: updated_completed.date_completed } }

    context 'when there is one completed in the database' do
      let(:todo) { Todo.create!({ name: 'ooh', info: 'ahh' }) }
      let!(:completed) { Completed.create!({ todo_id: todo.id, date_completed: DateTime.now }) }
      let(:updated_completed) { Completed.new({ todo_id: todo.id, date_completed: completed.date_completed - 3.days }) }

      it 'only has one completed before and after' do
        expect(Completed.count).to be 1
        request
        expect(Completed.count).to be 1
      end

      it 'updates the completed to the desired fields' do
        request
        expect(Completed.first.todo_id).to eq updated_completed.todo_id
        expect(Completed.first.date_completed).to eq updated_completed.date_completed.change(:usec => 0)
      end
    end
  end

  context 'when the delete endpoint is hit' do
    let(:request) { delete '/Completed/:id', :params => { completed: { id: completed.id }} }

    context 'when there is one Completed in the database' do
      let!(:completed) { Completed.create({ todo_id: todo.id, date_completed: DateTime.now }) }
      let(:todo) { Todo.create!({ name: 'ohh', info: 'ahh' }) }

      it 'deletes the completed' do
        expect(Completed.count).to be 1
        request
        expect(Completed.count).to be 0
      end
    end
  end
end
