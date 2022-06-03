Rails.application.routes.draw do
  resources :cache_nodes, constraints: { format: 'json' }, only: [:index, :create, :update, :destroy]
  resources :database_nodes, constraints: { format: 'json' }, only: :index do
    collection do
      post :apply
    end
  end

  root to: 'home#index'
  post 'home/reset', to: 'home#reset'
end
