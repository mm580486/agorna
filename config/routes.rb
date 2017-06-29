Rails.application.routes.draw do


  






  namespace :admin do
  get 'seller_chains/index'
  end

  namespace :admin do
  get 'seller_chains/new'
  end

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
    
     resources :comments,controller: 'comments' do
       member do
        get 'delete'
        get 'toggle_lock'
       end
    end
    
         resources :seller_chains,controller: 'seller_chains' do
       member do
        get 'delete'
        get 'toggle_lock'
        get 'requests'
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
        get 'dashboard/plans'
    post 'dashboard/update_setting'
    
    
  end


  # devise_for :users
  devise_for :users, class_name: 'FormUser', :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'users/registrations'}

post '/password/reset/sms' => 'public/home#reset_password', as: :reset_password


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
  get 'dashboard/profile'
  post 'dashboard/update_profile'
   get 'dashboard/ads'
   get 'dashboard/password'
   post 'dashboard/update_password'
    post 'dashboard/send_ads'
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
  get 'page/:permalink' => 'public/home#page',as: :page
  
 namespace :public do
  namespace :home do
    get 'register_exposition'
    post 'save_exposition'
    get 'inbox'
    get 'following'
    get 'following_post'
    get 'category'
    get 'favorites'
    get 'search'
   
    
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




 # API routes
  namespace :api do
    namespace :v1 do
      
    get 'categories' 
    
    get 'subcategories/:id' , action: :subcategories
    get 'expositions/:type',action: :expositions
    get 'exposition/:id',action: :exposition
    get 'tickets/:token',action: :tickets
    get 'conversation/:token',action: :conversation
    get 'profile/:token',action: :profile
    get 'update_profile/:token',action: :update_profile
    get 'product_categories/:token',action: :product_categories
    get 'slider',action: :slider
    get 'category_fields/:token',action: :category_fields
    get 'save_product/:token',action: :save_product
    get 'register_exposition',action: :register_exposition
    
    post 'save_product/:token',action: :save_product
    
    get 'delete_product/:token',action: :delete_product
    get 'search/:type',action: :search
    get 'exposition_comments/:id',action: :exposition_comments
    
    
    get 'favorite/:token',action: :favorite
    get 'marketer_sellers/:token',action: :marketer_sellers
    get 'add_seller/:token',action: :add_seller
    
    get 'follow/:id',action: :follow
    get 'following/:token',action: :following
    get 'exposition_filters/:id',action: :exposition_filters
    get 'filter/:id',action: :filter
    get 'build_conversation/:token',action: :build_conversation
    get 'checkNewMessage/:token',action: :checkNewMessage
    get 'startmessage/:token',action: :startmessage
    get 'hasNewTickets/:token',action: :hasNewTickets
    
    
    post 'save_product_image/:id',action: :save_product_image
    get 'nearby',action: :nearby
    get 'show_exposition/:id',action: :show_exposition
    get 'products/:type',action: :products
    get 'product/:id',action: :product
    get 'save_comment/:id',action: :save_comment
    
    get 'favorites/:token',action: :favorites
    get 'product_comments/:id',action: :product_comments
    match 'login',via: [:get,:post,:options]
    match 'register',via: [:get,:post,:options]
      
    end
    
    
  end
  
  
  
  
end
