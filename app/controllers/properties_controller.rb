class PropertiesController < ApplicationController
    #To remove duplication inside following methods:
    before_action :set_property, only: [:edit, :update, :show, :destroy]
    #Adding security layer. It should protect also Reports controller!
    before_action :require_user
    #ToDo should I block access to any other property unless owner or admin?
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
      if current_user.admin?
         @properties = Property.paginate(page: params[:page],per_page: 5)
      else
         @properties = Property.where(user_id: session[:user_id]).paginate(page: params[:page],per_page: 5)
      end
    end
    
    def new
        @property = Property.new
    end
    
    def create
        @property = Property.new(property_params)
        #Workaround until user validation is added
        @property.user = current_user
        if @property.save
            flash[:success] = "Property was successfully created"
            redirect_to property_path(@property)
        else
            render 'new'
        end
    end
    
    def show
    end
    
    def edit
    end
    
    def update
        if @property.update(property_params)
            flash[:success] = "Property was successfully updated"
            redirect_to property_path(@property)
        else
            render 'edit'
        end
    end
    
    def destroy
        @property.destroy
        flash[:danger] = "Property was successfully deleted"
        redirect_to properties_path
    end
    
    private 
    
        def set_property
            @property= Property.find(params[:id])
        end
            
        def property_params
            params.require(:property).permit(:property_name,:description,:owner_id, :value)
        end

        def require_same_user
            if (current_user != @property.user) && !current_user.admin
                flash[:danger] = "You can only edit or delete your own property"
                redirect_to root_path
            end
        end
        
end