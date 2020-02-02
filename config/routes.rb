# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
    resources :like
    post 'update_like', to: 'like#update_like'
end