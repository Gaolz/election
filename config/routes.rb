Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount RuCaptcha::Engine => "/rucaptcha"

  get "auth/wechat/callback", to: "items#check"
  get 'follow', to: "items#follow", as: :follow
  get "search", to: "items#search", as: :search

  resources :categories, only: [:index, :show] do
    resources :items, only: [:index, :show]
  end

  resources :items, only:  [:show, :create] do
    put :vote, on: :member
    collection do
      get :wechat_ranks, :weibo_ranks
    end
  end

  root to: 'categories#index', as: :root


  namespace :admin do
    resources :items do
      collection do
        get :wechat_ranks, :weibo_ranks
      end
    end
    resources :categories do
      get :ranks, on: :collection
    end
    resources :sessions, only: [:new, :create, :destroy]
    resource :door, only: [:show, :update]
    root to: 'categories#index', as: :root
  end
end
