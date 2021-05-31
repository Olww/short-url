Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'short_url/:internal_path', to: 'short_urls#show'
  post 'short_url/', to: 'short_urls#create'
end
