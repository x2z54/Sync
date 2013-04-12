Box::Application.routes.draw do
  root :to => "welcome#index"
  get "registration" => "registration#index"
  get "download" => "registration#download"
  get "deleteUser" => "users#refreshDB"
  get "completeReg" => "registration#refreshDB"
  resources :registration
  resources :users
  get "log_out" => "sessions#destroy", :as => "log_out"
  resources :sessions, :only => [:new, :create, :destroy]
end
