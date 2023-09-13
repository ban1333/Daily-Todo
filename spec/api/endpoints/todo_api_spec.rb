require 'rails_helper'

describe 'TodoApi' do
  let(:res) { JSON.parse(response.body)[0] }

  context 'todo endpoints' do
    context 'post' do
      let(:request) { post '/Todo/todo', :params => { name: name, info: info } }
      let(:name) { 'clean' }
      let(:info) { 'room' }
      let(:name_2) {'ooga'}
      let(:info_2) {'booga'}
      let(:name_3) {'looga'}
      let(:info_3) {'fooga'}

      it 'does not error out' do
        request
        expect(response.status).to be 201
      end

      it 'creates a new todo' do
        request
        expect(Todo.count).to be 1
        expect(Todo.first.name).to eq name
        expect(Todo.first.info).to eq info
      end

      it 'creates multiple todos' do
        request
        post '/Todo/todo', :params => { name: name_2, info: info_2 }
        post '/Todo/todo', :params => { name: name_3, info: info_3 }
        expect(Todo.count).to eq 3
        expect(Todo.first.name).to eq name
        expect(Todo.first.info).to eq info
        expect(Todo.second.name).to eq name_2
        expect(Todo.second.info).to eq info_2
        expect(Todo.third.name).to eq name_3
        expect(Todo.third.info).to eq info_3
      end
    end

    context 'put' do
      let(:response) { put '/Todo/:id', :params => { todo: { id: Todo.first.id, name: name, info: info }}}
      let(:name) { 'this is new' }
      let(:info) { 'so is this' }
      let(:old_name) { 'this is old' }
      let(:old_info) { 'this old too' }

      before do
        Todo.create({name: old_name, info: old_info})
      end

      it 'updates the values of a todo' do
        expect(Todo.first.name).to eq old_name
        expect(Todo.first.info).to eq old_info
        response
        expect(Todo.first.name).to eq name
        expect(Todo.first.info).to eq info
      end
    end

    context 'get' do
      let(:request) { get '/Todo/todo' }

      context 'when there are no todos' do
        it 'does not return a todo' do
          request
          expect(res).to eq nil
        end
      end

      context 'when there is one todo' do
        let(:name) { 'ooga' }
        let(:info) { 'booga' }

        before do
          Todo.create!({
                         name: name,
                         info: info
                       })
        end

        it 'gets the todo' do
          request
          expect(res['name']).to eq name
          expect(res['info']).to eq info
        end
      end

      context 'when there are multiple todos' do
        let(:name) { 'ahh' }
        let(:info) { 'ohh' }
        let!(:todo_1) { Todo.create!({ name: name, info: info })}
        let!(:todo_2) { Todo.create!({ name: name, info: info })}
        let!(:todo_3) { Todo.create!({ name: name, info: info })}

        it 'gets the todo' do
          request
          expect(JSON.parse(response.body).count).to eq 3
          expect(res['name']).to eq name
          expect(res['info']).to eq info
        end
      end
    end

    context 'get todos for today' do
      let(:request) { get '/Todo/today_todo' }

      context 'when there are no todos scheduled for today' do
        it 'returns nil' do
          request
          expect(res).to eq nil
        end
      end

      context 'when there is one todo scheduled for today' do
        let(:todo) { Todo.create!({ name: 'ooga', info: 'booga' })}
        let!(:schedule) { Schedule.create!({ todo_id: todo.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }

        it 'returns the todo' do
          request
          expect(res).to eq todo
        end
      end

      context 'when there are multiple todos scheduled for today' do
        let(:todo_1) { Todo.create!({ name: 'ooga', info: 'booga' })}
        let!(:schedule_1) { Schedule.create!({ todo_id: todo_1.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
        let(:todo_2) { Todo.create!({ name: 'ooga', info: 'booga' })}
        let!(:schedule_2) { Schedule.create!({ todo_id: todo_2.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
        let(:todo_3) { Todo.create!({ name: 'ooga', info: 'booga' })}
        let!(:schedule_3) { Schedule.create!({ todo_id: todo_3.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }

        it 'returns three todos' do
          request
          expect(JSON.parse(response.body).count).to eq 3
          expect(JSON.parse(response.body)[0]).to eq todo_1
          expect(JSON.parse(response.body)[1]).to eq todo_2
          expect(JSON.parse(response.body)[2]).to eq todo_3
        end
      end

      context 'when there are multiple todos scheduled for today but some are not' do
        let(:todo_1) { Todo.create!({ name: 'ooga', info: 'booga' })}
        let!(:schedule_1) { Schedule.create!({ todo_id: todo_1.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
        let(:todo_2) { Todo.create!({ name: 'ooga', info: 'booga' })}
        let!(:schedule_2) { Schedule.create!({ todo_id: todo_2.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
        let(:todo_3) { Todo.create!({ name: 'ooga', info: 'booga' })}
        let!(:schedule_3) { Schedule.create!({ todo_id: todo_3.id, sunday: 1, monday: 1, tuesday: 1, wednesday: 1, thursday: 1, friday: 1, saturday: 1 }) }
        let(:todo_not_today_1) { Todo.create!({ name: 'ooga', info: 'booga' })}
        let!(:schedule_not_today_1) { Schedule.create!({ todo_id: todo_not_today_1.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }
        let(:todo_not_today_2) { Todo.create!({ name: 'ooga', info: 'booga' })}
        let!(:schedule_not_today_2) { Schedule.create!({ todo_id: todo_not_today_2.id, sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }) }

        before do
          todo_1.schedule_id = schedule_1
        end

        it 'only returns the three todos scheduled for today' do
          request
          expect(JSON.parse(response.body).count).to eq 3
          expect(JSON.parse(response.body)[0]).to eq todo_1
          expect(JSON.parse(response.body)[1]).to eq todo_2
          expect(JSON.parse(response.body)[2]).to eq todo_3
        end
      end
    end

    context 'delete' do
      context 'when there is one todo' do
        let(:request) { delete '/Todo/:id', :params => { todo: { id: Todo.first.id } } }

        before do
          Todo.create!({ name: 'ahh', info: 'ohh' })
        end

        it 'deletes the todo' do
          expect(Todo.count).to be 1
          request
          expect(Todo.count).to be 0
        end
      end

      context 'when there are multiple todos' do
        let(:request) { delete '/Todo/:id', :params => { todo: { id: Todo.first.id } } }
        let(:name) { 'ahh' }
        let(:info) { 'ohh' }

        before do
          Todo.create!({ name: 'delete', info: 'me' })

          2.times do
            Todo.create!({ name: name, info: info })
          end
        end

        it 'deletes only one todo' do
          expect(Todo.count).to be 3
          request
          expect(Todo.count).to be 2
          expect(Todo.first.name).to eq name
          expect(Todo.second.name).to eq name
        end
      end
    end
  end
end
