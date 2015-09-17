Rails.application.routes.draw do
  root to: "questions#index"

  get "/auth/:provider/callback" => "sessions#create"

  get "/signout" => "sessions#destroy", :as => :signout

  resources :questions do
    resources :answers
  end

  resources :answers

  resources :sessions
end
