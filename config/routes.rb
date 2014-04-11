Baller::Application.routes.draw do

  get '/about', to: 'welcome#about'
  get '/courts/admin-index', to: 'courts#admin_index'
  get '/courts/search', to: 'courts#search'
  get '/games', to: 'games#index'
  get '/comments', to: 'comments#admin_index'
  get '/comments/submit', to: 'comments#submit'
  post '/comments/:id/approval', to: 'comments#approval'
  get '/games/:id/players', to: 'games#players'
  post '/games/:game_id/users/:id', to: 'games#remove_player'
  post '/games/:id/remove-current', to: 'games#remove_current'
  post '/games/:id/add-current', to: 'games#add_current'
  resources :users
  resources :courts, shallow: true do
    resources :comments
    resources :games
  end

  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  root to: 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
