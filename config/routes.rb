Rails.application.routes.draw do
  get 'home/index'
  get 'home/reset'
  resources :database_nodes, constraints: { format: 'json' }, only: :index
  resources :cache_nodes, constraints: { format: 'json' }, only: :index
end
