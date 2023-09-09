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
end
