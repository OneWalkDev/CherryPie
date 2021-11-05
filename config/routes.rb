Rails.application.routes.draw do
  get 'profiles/index'
  get 'profiles/show'
  devise_for :users, controllers: {
      :confirmations => 'users/confirmations',
      registrations: "users/registrations",
  }

  devise_scope :user do
    patch "users/confirm" => "users/confirmations#confirm"
  end

  resources :pages
  resources :profiles, only: [:index, :show] do
    resources :relationships, only: [:create, :destroy]
  end

  get "/"=>'tops#index'
  get "/about"=>'tops#about'


  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
