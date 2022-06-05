Rails.application.routes.draw do

  #ユーザー部分
  root to: "public/homes#top"
  get "homes/about" => "public/homes#about", as: "about"

  get "/users/my_page" => "public/users#show", as: "my_page"
  get "/users/edit" => "public/users#edit", as: "edit_users"
  patch "users" => "public/users#update"
  get "/users/unsubscribe" => "public/users#unsubscribe", as: "unsubscribe"
  patch "/users/withdrawal" => "public/users#withdrawal", as: "withdrawal"

  resources :coordinates, only:[:index, :new, :show, :edit, :create, :update, :destroy], controller: "public/coordinates" do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :items, only:[:index, :new, :show, :edit, :create, :update, :destroy], controller: "public/items"


  #devise部分
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  #管理者部分
  namespace :admin do
    resources :users, only:[:index,:show,:edit,:update]
    resources :coordinates do
      resources :comments, only: [:destroy]
    end
  end
  get "/admin" => "admin/homes#top", as: "admin"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
