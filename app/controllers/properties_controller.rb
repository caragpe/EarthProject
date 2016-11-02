class PropertiesController < ApplicationController
    def new
        @property = Property.new
    end
    
    def create
        #render plain: params[:property].inspect
        @property = Property.new(property_params)
        @property.save
        if @property.errors.any?
            render plain: @property.errors.full_messages
        end
    end
    
    private
    def property_params
        params.require(:property).permit(:property_name,:description)
    end
end