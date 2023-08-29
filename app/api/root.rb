require "grape"

class Root < Grape::API
  format :json

  mount Test::API
  mount Endpoints::TodoApi
end
