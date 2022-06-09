Rails.application.routes.draw do
  
  namespace :public do
    get 'coordinate_items/new'
    get 'coordinate_items/edit'
  end
  namespace :public do
    get 'items/new'
    get 'items/index'
  end
  #devise部分
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  #ユーザー部分
  scope module: :public do
    root to: "homes#top"
    get "homes/about" => "homes#about", as: "about"
  
    get "/users/my_page" => "users#my_page", as: "my_page"
    get "/users/:id" => "users#show", as: "user"
    # user/editのようにするとdeviseのルーティングとかぶってしまうためprofileを付け加えている。
    get "/users/profile/:id/edit" => "users#edit", as: "edit_profile"
    patch "users/profile" => "users#update", as: "update_profile"
    get "/users/profile/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
    patch "/users/withdrawal" => "users#withdrawal", as: "withdrawal"
    delete "/users" => "users#destroy", as: "user_destroy"
  
    resources :coordinates, only:[:index, :new, :show, :edit, :create, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    
    resources :coordinate_items, only: [:new, :create, :edit, :update]
  
    resources :items, only:[:index, :new, :show, :edit, :create, :update, :destroy]
  end


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
