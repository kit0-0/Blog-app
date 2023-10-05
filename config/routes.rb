Rails.application.routes.draw do
  resources :users do
    resources :posts do
      member do
        post 'like'
      end
      resources :comments
    end
  end  
end
