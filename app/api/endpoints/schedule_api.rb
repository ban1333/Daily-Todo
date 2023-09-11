require 'grape'

module Endpoints
  class ScheduleApi < Grape::API
    resource Schedule do
      desc 'Returns all Schedules'
      get :schedule do
        Schedule.all
      end

      desc 'Returns all of a single todo\'s schedule'
      params do
        requires :id, type: String, desc: 'the id of the todo you wish to get'
      end
      get ':id' do
        Schedule.where(todo_id: params[:schedule][:id])
      end

      desc 'Creates a Schedule'
      params do
        requires :todo_id, type: String, desc: 'the id of the Todo'
        requires :sunday, type: String
        requires :monday, type: String
        requires :tuesday, type: String
        requires :wednesday, type: String
        requires :thursday, type: String
        requires :friday, type: String
        requires :saturday, type: String
      end
      post :schedule do
        Schedule.create!({ todo_id: params[:todo_id],
                           sunday: params[:sunday],
                           monday: params[:monday],
                           tuesday: params[:tuesday],
                           wednesday: params[:wednesday],
                           thursday: params[:thursday],
                           friday: params[:friday],
                           saturday: params[:saturday]
                         })
      end

      desc 'Updates a Schedule'
      params do
        requires :todo_id, type: String, desc: 'the id of the Todo'
        requires :id, type: String, desc: 'the id of the schedule'
        requires :sunday, type: String
        requires :monday, type: String
        requires :tuesday, type: String
        requires :wednesday, type: String
        requires :thursday, type: String
        requires :friday, type: String
        requires :saturday, type: String
      end
      put ':id' do
        Schedule.find(params[:schedule][:id]).update!({
                                                        todo_id: params[:todo_id],
                                                        sunday: params[:sunday],
                                                        monday: params[:monday],
                                                        tuesday: params[:tuesday],
                                                        wednesday: params[:wednesday],
                                                        thursday: params[:thursday],
                                                        friday: params[:friday],
                                                        saturday: params[:saturday]
                         })
      end

      desc 'Deletes a Schedule'
      params do
        requires :id, type: String, desc: 'the id of the schedule'
      end
      delete ':id' do
        Schedule.find(params[:schedule][:id]).delete
      end
    end
  end
end
