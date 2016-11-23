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
    #    if !@property.reports.empty?
    #        @report_old = Report.find(@property.reports.ids)
    #    end

    #    @report = Report.new(report_params)
    #    if @report.filename?
    #        add_update_report
    #    else
            if @property.update(property_params)
                flash[:success] = "Property was successfully updated"
                redirect_to property_path(@property)
            else
                render 'edit'
            end
    #    end
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
        
        def add_update_report
            if @property.reports.last.save
                flash[:success] = "Property and report were successfully created"
                redirect_to property_path(@property)
            else
                if @property.reports.last.errors.any?
                    check_report_error
                end
            end
        end
        
                
#            @report.property = @property
#            if @report.save
#                if !@report_old.nil?
#                    @report_old.last.destroy
#                end
#                flash[:success] = "Property and report were successfully created"
#                redirect_to property_path(@property)
#            else
#                if @report.errors.any?
#                    @property.destroy
#                    check_report_error
#                end
#                render 'new'
#            end
#        end
        
        def check_report_error
            if @property.reports.last.errors.any?
                @property.reports.last.errors.full_messages.each do |msg|
                    @property.errors.add(:report,msg)
                end
            end
        end
        

end