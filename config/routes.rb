Box::Application.routes.draw do
  root :to => "welcome#index"
  get "registration" => "registration#index"
  get "download" => "registration#download"
  get "deleteUser" => "users#refreshDB"
  get "completeReg" => "registration#refreshDB"
  get "deleteFile" => "files#delete_file"
  get "downloadFile" => "files#download_file"
  get "getFolder" => "files#get_folder"
  resources :registration
  resources :users
  resources :files
  resources :about
  get "log_out" => "sessions#destroy", :as => "log_out"
  resources :sessions, :only => [:new, :create, :destroy]
end
