Rails.application.routes.draw do
  devise_for :users, controllers: {
      :confirmations => 'users/confirmations',
  }
  devise_scope :user do
    patch "users/confirm" => "users/confirmations#confirm"
  end
  resources :pages

  get "/"=>'tops#index'
  get "/about"=>'tops#about'


  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
