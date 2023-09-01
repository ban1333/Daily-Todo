require 'grape'

module Endpoints
  class ScheduleApi < Grape::API
    resource Schedule do
      desc 'Returns all Schedules'
      get :schedule do
        Schedule.all
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
        Schedule.create!({ todo_id: todo_id,
                           sunday: sunday,
                           monday: monday,
                           tuesday: tuesday,
                           wednesday: wednesday,
                           thursday: thursday,
                           friday: friday,
                           saturday: saturday
                         })
      end
    end
  end
end
