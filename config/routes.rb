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
  
  namespace :system_admins do
    resources :schools
    resources :teachers, only: %i(index destroy)
  end

  resources :system_admins

  resource :teachers, only: :show do
    get '/creator', to: 'teachers#creator'
    resources :students do
      namespace :alergy_checks do
        resources :creator, only: %i(edit update destroy)
      end
    end
    resource :students do
      namespace :alergy_checks do
        resource :creator, only: %i(new create)
      end
    end
  end

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