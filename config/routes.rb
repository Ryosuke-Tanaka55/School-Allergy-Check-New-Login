Rails.application.routes.draw do
  devise_for :system_admins, controllers: {
    sessions:      'system_admins/sessions',
    passwords:     'system_admins/passwords',
  }
  devise_for :teachers, controllers: {
    sessions:      'teachers/sessions',
    passwords:     'teachers/passwords',
    registrations: 'teachers/registrations',
    # omniauth_callbacks: "teachers/omniauth_callbacks"
  }
  # devise_for :teachers, path: system_admins/teachers, controllers: {
  #   registrations: 'system_admins/teachers/registrations',
  # }
  
  namespace :system_admins do
    resources :schools do
      resources :teachers
    end
  end

  resources :system_admins
  # resources :schools do
  #   resources :teachers
  # end

  # 下記山田さん既存のルート
  resources :students do  
    collection { post :import }  
  end 
  
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get  'comfirmation'
    end
    
    resources :attendances, only: [:edit, :update] do
     member do  
       get 'lunch_check'
       patch 'update_lunch_check'
     end   
     collection do
        get 'lunch_check_info'
        patch 'update_lunch_check_info'   
     end #collection do end
    end #resouces do end
  end #user resouces do end 
end
#draw do end