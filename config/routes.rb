ProductRecall::Application.routes.draw do


  get "paypal/new"

  get "paypal/edit"

  #get "admin_feature/edit"
  get "password_resets/new"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :vendors
  resources :suppliers
  resources :histories
  resources :password_resets
  resources :paypal

  root to: 'administrator_pages#home'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete


  match '/about',   to: 'administrator_pages#about'
#  match '/recalls',  to: 'administrator_pages#Recalls'

  match 'recall',  to:'administrator_pages#create'
  match 'destroy', to: 'administrator_pages#destroy'
#  match 'edit', to: 'administrator_pages#edit'
  match '/recalls',  to: 'administrator_pages#Recalls', :as => :recalls
  match '/recalls1', to: 'administrator_pages#Recalls1', :as => :recalls1
  match '/recalls2', to: 'administrator_pages#Recalls2', :as => :recalls2
  match '/recalls3', to: 'administrator_pages#Recalls3', :as => :recalls3


  match '/edit/:id', to: 'administrator_pages#edit', :as => :edit_recall
  put '/update/:id', to: 'administrator_pages#update', :as => :update_recall

#  get "administrator_pages/Recalls"
  get "users/new"

  get "paid_user/paid"

  get "basic_user/basic"

  match "/search",  to: 'search#Search', :as => :search

  match "/update",to: 'update#All',:as => :update

    match "/email", to: 'emailer#index'
    match "/emailer", to: 'emailer#sendmail'

    match "/admin_feature", to: 'admin_feature#edit'
    match "/admin_feature/update",to: 'admin_feature#update'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
