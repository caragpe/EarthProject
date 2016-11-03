class PropertiesController < ApplicationController
    
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
            flash[:notice] = "Property was successfully created"
            redirect_to property_path(@property)
        else
            render 'new'
        end
    end
    
    def show
        @property = Property.find(params[:id])
    end
    
    def edit
        @property = Property.find(params[:id])
    end
    
    def update
        @property = Property.find(params[:id])
        if @property.update(property_params)
            flash[:notice] = "Property was successfully updated"
            redirect_to property_path(@property)
        else
            render 'edit'
        end
    end
    
    private
        def property_params
            params.require(:property).permit(:property_name,:description,:owner_id, :value)
        end
end