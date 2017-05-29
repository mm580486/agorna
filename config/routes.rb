Rails.application.routes.draw do


  





  namespace :admin do
    resources :pages,controller: 'pages' do
       member do
        get 'delete'
        get 'toggle_lock'
       end
    end
    
    resources :categories,controller: 'categories' do
       member do
        get 'delete'
       end
    end
    
    
    resources :marketers,controller: 'marketer' do
       member do
        get 'delete'
       end
    end
    
    
     resources :sellers,controller: 'sellers' do
       member do
        get 'delete'
        get 'toggle_lock'
       end
    end
    
        
     resources :forms,controller: 'forms' do
       member do
        get 'delete'
        get 'toggle_lock'
        get 'show_fields'
        get 'new_field'
        post 'save_fields'
        get 'delete_field'
        get 'edit_field'
        
        get 'new_prop'
        post 'save_props'
        get 'delete_prop'
        get 'edit_prop'
        get 'show_props'
        
       end
    end
    
    
        resources :products,controller: 'products' do
       member do
        get 'delete'
        get 'toggle_lock'
       end
    end
    
    
            resources :seller_products,controller: 'seller_products' do
       member do
        get 'delete'
        get 'toggle_lock'
       end
    end
    
    
    get 'dashboard/setting'
    
    
  end


  # devise_for :users
  devise_for :users, class_name: 'FormUser', :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}


  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'omniauth_callbacks#setup'
  end
  
  namespace :admin do
  get 'dashboard/index'
  get 'dashboard/change_development_mode'
  
  end

  namespace :admin do
  get 'dashboard/login'
  get 'dashboard/sms_service'
  get 'dashboard/setting'
  get 'dashboard/transaction'
  end

  namespace :admin do
  get 'dashboard/logout'
  end
  get 'update',to: 'public/home#update',:as => :update
  get 'product/favorite',to: 'public/home#favorite'
  get 'product/:id',to: 'public/home#product',:as => :product_show
  
  get 'exposition/show/:id',to: 'public/exposition#show',:as => :exposition_show
  post 'exposition/create_comment',to: 'public/exposition#create_comment',:as => :create_comments
  
  get 'exposition/follow',to: 'public/exposition#follow'
  get 'exposition/rate',to: 'public/exposition#rate'

  
 namespace :public do
  namespace :home do
    get 'register_exposition'
    post 'save_exposition'
    get 'inbox'
    get 'following'
    get 'following_post'
    get 'category'
    get 'favorites'
    
  end
  
    resources :tickets,controller: 'tickets' do
     member do
        get 'conversation'
        post 'save_conversation'
        
       end
    end
 
  
  
end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'public/home#index'

  namespace :api do
    namespace :v1 do
      
    get 'categories' 
    match 'login',via: [:get,:post,:options]
    match 'register',via: [:get,:post,:options]
      
    end
    
    
  end
  
  
  
  
end
