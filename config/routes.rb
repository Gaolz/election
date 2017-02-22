Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :items
    resources :categories
    resources :sessions, only: [:new, :create, :destroy]
    root to: 'categories#index', as: :root
  end

  resources :categories, only: [:index, :show] do
    resources :items, only: [:index, :show]

    get :ranks, on: :collection
  end

  root to: 'categories#index', as: :root
  resources :items, only:  :show do
    put :vote, on: :member
    collection do
      get :wechat_ranks, :weibo_ranks
    end
  end
end
