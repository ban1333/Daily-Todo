require "grape"

module Test
  class API < Grape::API
    format :json

    get :world do
      {
        "response"=>"hello world!",
        "name"=>"david"
      }
    end
  end
end