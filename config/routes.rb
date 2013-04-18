Box::Application.routes.draw do
  root :to => "welcome#index"
  get "registration" => "registration#index"
  get "download" => "registration#download"
  get "deleteUser" => "users#refreshDB"
  get "completeReg" => "registration#refreshDB"
  get "deleteFile" => "files#delete_file"
  get "downloadFile" => "files#download_file"
  resources :registration
  resources :users
  resources :files
  get "log_out" => "sessions#destroy", :as => "log_out"
  resources :sessions, :only => [:new, :create, :destroy]
end
