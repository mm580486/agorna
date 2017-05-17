class Public::HomeController < ApplicationController
    layout 'public'
    before_action :exec_setting
    before_action :check_development_mod,except: :update
    def index
        
    end
    
    def update
      
    end
    
    def register_exposition
        @user = User.new
    end
    
    def save_exposition
        @user = User.new(exposition_white_list)
        @user.level = 1
        @user.level = true
        if @user.save
            redirect_to root_path
        else 
            render 'register_exposition'
        end
    end
    
    
    
    private
    
    def exposition_white_list
        params.require(:user).permit(:name,:phone,:exposition_name,:exposition_address,:instagram,:telegram,:post_service)
    end
    
    
    
    
end
