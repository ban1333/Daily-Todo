require "grape"

module Test
  class API < Grape::API

    get :world do
      {
        "response"=>"hello world!",
        "name"=>"david"
      }
    end
  end
end
