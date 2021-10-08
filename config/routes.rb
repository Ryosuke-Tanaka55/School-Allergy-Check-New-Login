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

  # devise_scope :teachers do
  #   get 'schools/'
  # end
  
  resources :system_admins, only: %i(index)

  namespace :system_admins do
    resources :schools do
    end
  end

  resources :schools do
    resources :teachers
  end


  resource :teachers, only: :show do
    resources :students do
      resources :alergy_checks, only: %i(edit update destroy)
    end
    resource :students do
      resource :alergy_checks, only: %i(new create)
    end
  end

  get 'alergy_checks/new'


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
