Rails.application.routes.draw do
  root to: 'staticpages#home'
  get  '/help',    to: 'staticpages#help'
  get  '/about',   to: 'staticpages#about'
  get  '/contact', to: 'staticpages#contact'

  get 'signup', to: 'users#new'
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :account_activations, only: %i[edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
