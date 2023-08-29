require 'rails_helper'

describe 'todo' do
  let(:res) { JSON.parse(response.body)['response'] }

  context 'when creating a new todo' do
    let(:request) { post '/todo', :params => { name: name, info: info } }
    let(:name) { 'clean' }
    let(:info) { 'room' }

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
  end
end
