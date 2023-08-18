require "grape"

class Root < Grape::API
  format :json

  mount Test::API
end
