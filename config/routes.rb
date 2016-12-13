Rails.application.routes.draw do
  root to: "users#login"

  get "new" => "users#new"

  get "index" => "users#index"
  post "users" => "users#create"
  post "login" => "users#auth"

  get "face_auth/:id" => "users#face_auth"

  get "complete" => "users#complete"

  post "check" => "users#check"
  mount ActionCable.server => '/cable'
end
