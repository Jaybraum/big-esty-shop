Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"

  resources :merchants, module: :merchants do
    get '/dashboard', to: 'dashboard#show', as: 'merchant_dashboard'
    resources :items, except: :destroy
    resources :invoices
    resources :discounts
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :invoices, only: [:index, :show, :update]
    resources :merchants, except: [:destroy]
  end
end
