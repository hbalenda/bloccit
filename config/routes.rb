Rails.application.routes.draw do
  resources :posts

  get 'about' => 'welcome#about'
#declares default page
  root 'welcome#index'
end
