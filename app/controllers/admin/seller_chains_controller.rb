class Admin::SellerChainsController < ApplicationController
  layout 'admin'
  def index
    @chains=Chain.where(user_two: current_user.id)
  end

  def new
    @chian=Chain.new
  end
  
  def create
    
    @chian=current_user.chains.create(user_two: params[:user_two])
     flash[:notice]=[5000,t("admin.toast.chain_request")]
    redirect_to admin_seller_chains_path
  end
  
  def toggle_lock
    @chain=Chain.find(params[:id])
    @chain.update_attribute(:accept,!@chain.lock)
    flash[:notice]=[5000,t("admin.toast.chain_#{@chain.accept}")]
    redirect_to admin_seller_chains_path
  end
  
  
end
