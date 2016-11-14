class PropertiesController < ApplicationController
    #To remove duplication inside following methods:
    before_action :set_property, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
        @properties = Property.paginate(page: params[:page],per_page: 5)
    end
    
    def new
        @property = Property.new
    end
    
    def create
        @report = Report.new(report_params)
        @property = Property.new(property_params)
        #Workaround until user validation is added
        @property.user = current_user
        if @property.save
            if @report.filename?
                @report.property = @property
                if @report.save
                    flash[:success] = "Property and report were successfully created"
                    redirect_to property_path(@property)
                else
                    if @report.errors.any?
                        @property.destroy
                        check_report_error
                    end
                    render 'new'
                end
            else
                flash[:success] = "Property was successfully created"
                redirect_to property_path(@property)
            end
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
        
        def report_params
            params.require(:property).permit(:file)
        end
        
        def require_same_user
            if (current_user != @property.user) && !current_user.admin
                flash[:danger] = "You can only edit or delete your own property"
                redirect_to root_path
            end
        end
        
        def check_report_error
            if @report.errors.any?
                @report.errors.full_messages.each do |msg|
                    puts msg
                    @property.errors.add(:report,msg)
                end
            end
        end
        

end