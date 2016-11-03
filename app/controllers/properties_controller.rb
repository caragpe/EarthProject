class PropertiesController < ApplicationController
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
    
    private
    def property_params
        params.require(:property).permit(:property_name,:description,:owner_id, :value)
    end
end