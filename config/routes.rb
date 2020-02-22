# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
    resources :like
    post 'issues/update_like', to: 'like#update_like'
    post 'projects/:id/update_like', to: 'like#update_like'
    post 'projects/:id/wiki/update_like', to: 'like#update_like'
end