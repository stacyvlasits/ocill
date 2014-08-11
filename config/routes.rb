Ocill::Application.routes.draw do

  post "launch/create"

  post "panda/notifications"

  get "home/show"

  devise_for :users

  post '/tinymce_assets' => 'tinymce_assets#create'
 
  resources :roles
  
  resources :courses do
    resources :roles
    post 'create_many_roles' => 'roles#create_many_roles'
    resources :units
  end

  resources :users, only: [:index, :show] 

  resources :activities, only: [:edit, :update]

  resources :units do
    resources :drills
  end
  
  resources :drills do
    get 'read' => 'drills#read'
    member do
      get 'row/add' => 'drills#add_row'
      get 'column/add' => 'drills#add_column'
      get 'row(/:exercise_id)' => 'drills#remove_row'
      get 'column(/:header_id)' => 'drills#remove_column'
    end
    resources :attempts
    resources :exercises do
      resources :exercise_items
    end
  end

  resources :attempts
  
  resources :exercises do
    delete 'remove_audio' => 'exercises#remove_audio'
    resources :audio
  end
  
  resources :exercise_items do
    delete 'remove_audio' => 'exercise_items#remove_audio'
    resources :audio
  end

  root :to => "home#show"

end
