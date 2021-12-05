Rails.application.routes.draw do
  
  

  root 'static_pages#top'

  # システム管理者用画面
  devise_for :system_admins, controllers: {
    registrations: 'system_admins/registrations',
    sessions:      'system_admins/sessions',
    passwords:     'system_admins/passwords',
  }

  namespace :system_admins do
    resources :schools do
      resources :teachers, param: :tcode, only: %i[show new create edit update destroy]
    end
  end

  # 学校区分
  root to: 'static_pages#school_top', as: 'top'

  # 先生画面
  devise_for :teachers, skip: 'sessions', controllers: {
    passwords:     'teachers/passwords',
    registrations: 'teachers/registrations',
    # omniauth_callbacks: "teachers/omniauth_callbacks"
  }
  scope '/:school_url' do
    devise_scope :teacher do
      get 'teachers/sign_in', to: 'teachers/sessions#new', as: :new_teacher_session
      post 'teachers/sign_in', to: 'teachers/sessions#create', as: :teacher_session
    end
  end
  devise_scope :teacher do
    delete 'teachers/sign_in', to: 'teachers/sessions#destroy', as: :destroy_teacher_session
  end

  resource :teachers, except: %i(show create edit update destroy) do
    resources :school_students
    # 対応法作成ページ
    resources :creator_alergy_checks, except: %i(show)

    resources :admin_alergy_checks, only: [:edit, :update] do
      collection do  
        get 'lunch_check'
        patch 'update_lunch_check'
      end   
      member do
         get 'lunch_check_info'
         patch 'update_lunch_check_info'
         get 'lunch_check_all'
         patch 'update_lunch_check_all' 
      end #collection do end
     end #resouces do end
    resources :admin_alergy_checks do
    end
    resource :students do
      namespace :alergy_checks do
        resource :creator, only: %i(new create)
      end
    end

    resources :menus
    post 'create'
    get 'show', as: :show
    get 'edit_info'
    patch 'update_info'
    delete 'destroy', as: :destroy

    #担任ページ
    resource :alergy_checks, only: %i(show update) do
      collection do
        get 'today_index'
        get 'one_month_index'
      end
    end

    #代理報告ページ
    resource :charger_alergy_checks, only: %i(show)

    #管理職月間チェック一覧ページ
    collection do
      get '/admin_alergy_checks/one_month_index'
    end


  end
  resource :students do
    namespace :alergy_checks do
      resource :creator, only: %i(new create) do
        get '/students', to: 'creators#search_student'
      end
    end
  end

  resources :classrooms do
    collection do
      get 'edit_using_class'
      patch 'update_using_class'
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resource :teachers do
  resources :admin_alergy_checks, only: [:edit, :update] do
    collection do  
      get 'lunch_check'
      patch 'update_lunch_check'
    end   
    member do
       get 'lunch_check_info'
       patch 'update_lunch_check_info'
       get 'lunch_check_all'
       patch 'update_lunch_check_all' 
    end #collection do end
   end #resouces do end
  end #teachers do end

  # 下記山田さん既存のルート
  resources :students do
    collection { post :import }
  end

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
