Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/about'
#declares default page
  root 'welcome#index'
end
