Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
      :confirmations => 'users/confirmations',
      registrations: "users/registrations",
  }

  devise_scope :user do
    patch "users/confirm" => "users/confirmations#confirm"
  end

  resources :pages

  resources :expenses
  resources :profiles , only:[:index,:show] do
    resources :relationships, only: [:create, :destroy]
  end

  get "/"=>'tops#index'
  get "/about"=>'tops#about'
  get "profile/search"=>"profiles#search"


  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
