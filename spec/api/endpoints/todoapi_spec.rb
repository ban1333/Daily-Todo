require 'rails_helper'

describe 'todo' do
  let(:res) { JSON.parse(response.body)['response'] }

  context 'todo endpoints' do
    context 'post' do
      let(:request) { post '/todo', :params => { name: name, info: info } }
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
        post '/todo', :params => { name: name_2, info: info_2 }
        post '/todo', :params => { name: name_3, info: info_3 }
        expect(Todo.count).to eq 3
        expect(Todo.first.name).to eq name
        expect(Todo.first.info).to eq info
        expect(Todo.second.name).to eq name_2
        expect(Todo.second.info).to eq info_2
        expect(Todo.third.name).to eq name_3
        expect(Todo.third.info).to eq info_3
      end
    end
  end
end
