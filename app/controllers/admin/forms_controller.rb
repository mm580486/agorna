class Admin::FormsController < ApplicationController
 layout 'admin'
 before_action :find_form,:only => [:show,:update,:edit,:delete,:toggle_lock,:show_fields,:new_field,:save_fields]
 
  def index
    @forms=ProductType.all
  end
  
  def new
    @form=ProductType.new
  end
  
  def toggle_lock
    @form.update_attribute(:lock,!@form.lock)
    flash[:notice]=[5000,t("admin.toast.form_lock_#{@form.lock}")]
    redirect_to admin_forms_path
  end
  
  def create
      @form=ProductType.new(forms_white_list)
    if @form.save
      flash[:notice]=[5000,t('admin.toast.form_create')]
      redirect_to admin_forms_path
    else
      render('new') 
    end
  end

  def show
    
  end
  
 
  
  

  def edit
  end
  
  def delete
    if @form.destroy
      flash[:notice]=[5000,t('admin.toast.form_destroy')]
      redirect_to admin_forms_path
    else
      render('new') 
    end
  end
  
  def update
    if @form.update_attributes(forms_white_list)
      flash[:notice]=[5000,t('admin.toast.form_update')]
      redirect_to admin_forms_path
    else
      render('new') 
    end
  end
  
  # Fields manager 
  
  def show_fields
    @fields=@form.fields
    
  end
  
  def new_field
    @field=@form.fields.new
  end
  
  def save_fields
    @field=@form.fields.new(fields_white_list)

    render json: fields_white_list
    # if @field.save
      
    #        flash[:notice]=[5000,t('admin.toast.field_create')]
    #   redirect_to show_fields_admin_form_path(@field.product_type_id)
    # else
    #       render 'new_field' 
    # end
  end
  
  def edit_field
     @field=ProductField.find(params[:id])
  end
  
  def delete_field
    @field=ProductField.find(params[:id])
    @field.destroy
    flash[:notice]=[5000,t('admin.toast.field_delete')]
    redirect_to show_fields_admin_form_path(@field.product_type_id)
  end
  
  
  
  # Props manager 
  
  def show_props
    @props=ProductField.find(params[:id]).props
    
  end
  
  def new_prop
    @prop=ProductField.find(params[:id]).props.new
  end
  
  def save_props
    @props=ProductField.find(params[:id]).props.new(props_white_list)
    
    if @props.save
      
           flash[:notice]=[5000,t('admin.toast.prop_create')]
      redirect_to show_props_admin_form_path(@props.product_field_id)
    else
          render 'new_prop' 
    end
  end
  
  def edit_prop
     @prop=Prop.find(params[:id])
  end
  

  def update_prop
    @props=Prop.find(params[:id])
    @props.update_attributes(props_white_list)
    flash[:notice]=[5000,t('admin.toast.prop_update')]
    redirect_to show_props_admin_form_path(@props.product_field_id)
 end


  def delete_prop
    @prop=Prop.find(params[:id])
    @prop.destroy
    flash[:notice]=[5000,t('admin.toast.prop_delete')]
    redirect_to show_props_admin_form_path(@prop.product_field_id)
  end
  
  
  private
  def find_form
    @form=ProductType.find(params[:id])
  end
  
  def forms_white_list
    params.require(:product_type).permit(:name,:permalink)
  end
  
  def fields_white_list
    params.require(:product_field).permit(:name,:permalink,:field_type,:categories)
  end
  
  def props_white_list
    params.require(:prop).permit(:name,:permalink)
  end
  
end
