Ocill::Application.routes.draw do

  devise_for :users

  resources :audio, :exercise_items, :exercises, :courses, :attempts

  resources :units do
    resources :drills
  end
  
  resources :drills do
    member do
      get 'row/add' => 'drills#add_row'
      get 'column/add' => 'drills#add_column'
      delete 'row/remove(/:exercise_id)' => 'drills#remove_row'
      delete 'column/remove(/:header_id)' => 'drills#remove_column'
    end
    
    resources :exercises do
      resources :exercise_items
    end
  end

  root :to => "drills#index"

end
