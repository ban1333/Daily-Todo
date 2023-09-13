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
        requires :id, type: String, desc: 'the id of the todo you wish to get'
      end
      get ':id' do
        Completed.where(todo_id: params[:completed][:id])
      end

      desc 'Create a Completed'
      params do
        requires :todo_id, type: String, desc: 'the id of the todo'
        requires :date_completed, type: DateTime, desc: 'the date/time the todo was finished'
      end
      post :completed do
        Completed.create!({
                       date_completed: params[:date_completed],
                       todo_id: params[:todo_id]
                     })
      end

      desc 'Update a completed'
      params do
        requires :id, type: String, desc: 'the id of the completed'
        requires :date_completed, type: DateTime, desc: 'the date/time the todo was finished'
      end
      put ':id' do
        Completed.find(params[:completed][:id]).update!({
                                                date_completed: params[:date_completed].change(:usec => 0)
                                              })
      end

      desc 'Delete a completed'
      params do
        requires :id, type: String, desc: 'the id of the completed'
      end
      delete ':id' do
        Completed.find(params[:completed][:id]).delete
      end
    end
  end
end
