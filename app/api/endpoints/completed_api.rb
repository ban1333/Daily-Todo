require 'grape'

module Endpoints
  class CompletedApi < Grape::API
    resource Completed do

      desc 'Returns all Completed Todos'
      get :completed do
        Completed.all
      end

      desc 'Returns all of a single todo\'s Completed Todos'
      params do
        requires :id, type: String, desc: 'the id of the todo you wish to change'
      end
      get ':id' do
        Completed.where(todo_id: params[:id])
      end
    end
  end
end
