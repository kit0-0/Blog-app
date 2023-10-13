Rails.application.routes.draw do
  
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  devise_for :users
  root 'users#index'
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[new create]
    end
  end

  namespace :api, default: {format: :json} do
    namespace :v1 do
      resources :posts, only: %i[index] do
        resources :comments, only: %i[index create]
      end
    end
  end 
end
