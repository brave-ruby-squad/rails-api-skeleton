Rails.application.routes.draw do
  resources :articles, only: %i[show]
end
