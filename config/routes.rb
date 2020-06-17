Rails.application.routes.draw do
  resources :events do
      member do
        patch :close
      end
      resources :players, module: :events, only: [:update] do
        member do
          patch :assign
        end
      end
      resources :play_books, module: :events, only: [:update]
      collection { post :import }
  end

  resources :players
  resources :calendar
  resources :play_books, only: [:show,:new,:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: "home#index"


  

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :players, except: [:new, :edit]
      end
    end
  end
end
