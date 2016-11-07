class PropertiesController < ApplicationController
    #To remove duplication inside following methods:
    before_action :set_property, only: [:edit, :update, :show, :destroy]
    
    def index
        @properties = Property.all
    end
    
    def new
        @property = Property.new
    end
    
    def create
        #render plain: params[:property].inspect
        @property = Property.new(property_params)
        if @property.save
            flash[:success] = "Property was successfully created"
            redirect_to property_path(@property)
        else
            render 'new'
        end
    end
    
    def show
        @property = Property.find(params[:id])
    end
    
    def edit
        #@property = Property.find(params[:id])
    end
    
    def update
        #@property = Property.find(params[:id])
        if @property.update(property_params)
            flash[:success] = "Property was successfully updated"
            redirect_to property_path(@property)
        else
            render 'edit'
        end
    end
    
    def destroy
        #@property= Property.find(params[:id])
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
end