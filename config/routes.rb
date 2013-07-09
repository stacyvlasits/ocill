Ocill::Application.routes.draw do

  devise_for :users

  post '/tinymce_assets' => 'tinymce_assets#create'
  
  resources :courses do
    resources :roles
    resources :users
  end

  resources :units do
    resources :drills
  end
  
  resources :drills do
    member do
      get 'row/add' => 'drills#add_row'
      get 'column/add' => 'drills#add_column'
      delete 'row(/:exercise_id)' => 'drills#remove_row'
      delete 'column(/:header_id)' => 'drills#remove_column'
    end
    resources :attempts
    resources :exercises do
      resources :exercise_items
    end
  end

  resources :exercises do
    delete 'remove_audio' => 'exercises#remove_audio'
    resources :audio
  end
  
  resources :exercise_items do
    delete 'remove_audio' => 'exercise_items#remove_audio'
    resources :audio
  end

  root :to => "drills#index"

end
