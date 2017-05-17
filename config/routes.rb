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
  end

  namespace :admin do
  get 'dashboard/logout'
  end
  get 'update',to: 'public/home#update',:as => :update
  
 namespace :public do
  namespace :home do
    get 'register_exposition'
    post 'save_exposition'
  end
  
  
end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'public/home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  
  
  
  namespace :api do
    namespace :v1 do
      
    get 'categories' 
    match 'login',via: [:get,:post,:options]
    match 'register',via: [:get,:post,:options]
      
    end
    
    
  end
  
  
  
  
end
