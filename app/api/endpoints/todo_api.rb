require "grape"

module Endpoints
  class TodoApi < Grape::API
    resource Todo do
      desc 'Gets all todos'
      get :todo do
        Todo.all
      end

      desc 'Create a todo'
      params do
        requires :name, type: String, desc: 'the task you wish to complete'
        requires :info, type: String, desc: 'more info about the task'
      end
      post :todo do
        Todo.create!({
                       name: params[:name],
                       info: params[:info]
                     })
      end

      desc 'Update a todo'
      params do
        requires :id, type: String, desc: 'the id of the todo'
        optional :name, type: String, desc: 'the task you wish to complete'
        optional :info, type: String, desc: 'more info about the task'
      end
      put ':id' do
        Todo.find(params[:todo][:id]).update!({
                                                name: params[:todo][:name],
                                                info: params[:todo][:info]
                                              })
      end

      desc 'Delete a todo'
      params do
        requires :id, type: String, desc: 'the id of the todo'
      end
      delete ':id' do
        Todo.find(params[:todo][:id]).delete
      end
    end
  end
end
