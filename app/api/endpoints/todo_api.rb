require "grape"

module Endpoints
  class TodoApi < Grape::API

    # resource Todo do
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
    # end
  end
end
