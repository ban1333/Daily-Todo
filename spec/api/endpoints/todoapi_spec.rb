require 'rails_helper'

describe 'todo' do
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

      end
    end
  end
end
