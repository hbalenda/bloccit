Rails.application.routes.draw do

  resources :topics do
  resources :posts, except: [:index]
end

  resources :users, only: [:new, :create]

  get 'about' => 'welcome#about'
#declares default page
  root 'welcome#index'
end
