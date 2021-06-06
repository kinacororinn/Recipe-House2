Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :recipes, only: [:index, :show, :edit, :update, :new, :create, :destroy] do
   resource :favorites, only: [:create, :destroy]
   resources :recipe_comments, only: [:index, :show, :edit, :update, :create, :destroy]
  end
  get 'favorites/create'
  get 'favorites/destroy'
  get 'homes/about'
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
