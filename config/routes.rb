Rails.application.routes.draw do

  namespace :api do
    namespace :v1, constraints: { format: :json } do
      resources :teams
      # get 'user/current_user' => 'users#current_user'
      resource :user, only: [] do
        member do
          get :me
        end
      end
      resources :users, only: [ :index, :show ] do
        collection do
          get :no_bet
        end
        resources :matches, only: [:index]
      end
      resources :matches, only: [:index, :create, :destroy, :update] do
        resources :bets, only: [:create]
      end
      resources :bets do
        collection do
          post :bulk_update
        end
      end
    end
  end

  authenticated(:user, ->(user) { user.admin? }) do
    ActiveAdmin.routes(self)
  end

  devise_for :users

  get 'mains/index'

  root to: 'mains#index'
  get '*all', to: 'mains#index', constraints: { format: :html }

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
