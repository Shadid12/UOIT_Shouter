Rails.application.routes.draw do
  
  get 'tags/:tag', to: 'messages#index', as: :tag
  devise_for :users
  resources :messages do 
  	resources :comments
  end
  root 'messages#index'
end
