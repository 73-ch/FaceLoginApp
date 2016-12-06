Rails.application.routes.draw do
  root to: "users#login"

  get "new" => "users#new"
  post "users" => "users#create"
  post "login" => "users#auth"
  mount ActionCable.server => '/cable'
end
