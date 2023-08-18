require 'rails_helper'

describe 'Endpoints' do
  context 'when the endpoint "world" is hit' do
    context 'the response' do
      let(:res) { JSON.parse(response.body)['response'] }

      it 'returns hello world' do
        get '/world'
        expect(res).to eq 'hello world!'
      end
    end
  end
end
