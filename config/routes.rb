Rails.application.routes.draw do

  root "welcome#index"

  resources :charges, only: [:new, :create]

  resources :pages

  get 'about' => 'welcome#about'

  devise_for :users

  resources :users do
    member do
      put :downgrade
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
