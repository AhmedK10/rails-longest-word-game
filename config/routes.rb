Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Sets the root path route ("/") to the "new" action in the "games" controller
  root "games#new"

  get "/score", to: "games#score"
end
