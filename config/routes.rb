Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :items
    resources :categories
    resources :sessions, only: [:new, :create, :destroy]
    root to: 'categories#index', as: :root
  end
end
