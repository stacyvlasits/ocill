Ocill::Application.routes.draw do

<<<<<<< HEAD
  resources :courses

  resources :lessons

  resources :drills do
=======
  resources :audio, :exercise_items, :exercises, :courses

  resources :lessons do
    resources :drills

    
  end
  
  resources :drills do
    member do
      post 'row/add' => 'drills#add_row'
      post 'column/add' => 'drills#add_column'
      delete 'row/remove(/:exercise_id)' => 'drills#remove_row'
      delete 'column/remove(/:header_id)' => 'drills#remove_column'
      get 'perform'
      post 'submit'
    end
    
>>>>>>> experiments
    resources :exercises do
      resources :exercise_items
    end
  end

<<<<<<< HEAD
  resources :exercises

  resources :exercise_items
  
  match 'drills/:id/row/add' => 'drills#add_row'

  match 'drills/:id/column/add' => 'drills#add_column'

  match 'drills/:id/row/remove(/:exercise_id)' => 'drills#remove_row'

  match 'drills/:id/column/remove(/:header_id)' => 'drills#remove_column'
=======
  
>>>>>>> experiments

  root :to => "drills#index"

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
