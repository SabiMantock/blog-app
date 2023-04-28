Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
   root "users#index"

  get 'posts/:post_id/comments/new', to: 'comments#new'
post 'posts/:post_id/comments', to: 'comments#create'
post 'posts/:post_id', to: 'likes#create'
  post 'posts', to: 'posts#create'
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
     resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
end
