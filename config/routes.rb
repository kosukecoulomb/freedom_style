Rails.application.routes.draw do
  # devise部分
  devise_for :admin, controllers: {
    sessions: "admin/sessions",
  }
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # ユーザー部分
  scope module: :public do
    root to: "homes#top"
    get "homes/about" => "homes#about", as: "about"

    get "/users/my_page" => "users#my_page", as: "my_page"
    # user/editのようにするとdeviseのルーティングとかぶってしまうためprofileを付け加えている。
    get "/users/profile/:id/edit" => "users#edit", as: "edit_profile"
    patch "users/profile" => "users#update", as: "update_profile"
    get "/users/profile/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
    get "/users/profile/favorites" => "users#favorites", as: "favorites"
    resources :users, only: [:index, :show, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get :followings, on: :member
      get :followers, on: :member
    end

    get "coordinates/timeline" => "coordinates#timeline", as: "timeline"
    resources :coordinates, only: [:index, :new, :show, :edit, :create, :update, :destroy] do
      collection do
        get :choise_search
      end
      resources :comments, only: [:create, :destroy] do
        resource :reports, only: :create
      end
      resource :favorites, only: [:create, :destroy]
    end

    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      get "/collection/" => 'items#collection', on: :member, as: "collection"
    end

    resources :tags do
      get '/coordinates' => 'coordinates#tag_search'
    end

    resources :notifications, only: :index
  end

  # 管理者部分
  namespace :admin do
    get '/' => 'homes#top', as: 'top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :coordinates, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :items, only: [:index, :show, :destroy]
    resources :reports, only: [:index, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
