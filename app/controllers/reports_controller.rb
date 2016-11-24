class ReportsController < ApplicationController
    before_action :set_property, except: [:show]
    before_action :set_report, only: [:show, :edit, :update, :destroy]
    
    # GET /properties/:property_id/reports
    def index
        #@property = Property.find(params[:property_id])
        @reports = @property.reports.order(:year, desc)
    end
    
    # GET /properties/:property_id/reports/:id(.:format) 
    def show
      send_data(@report.file_contents, type: @report.content_type, filename: @report.filename)
    end

    # GET /properties/:property_id/reports/new(.:format)
    def new
        @report = @property.reports.new
    end
    
    # POST /properties/:property_id/reports(.:format)
    def create
        @report = @property.reports.new(report_params)
        if @report.save
            flash[:success] = "Report was successfully uploaded"
            redirect_to property_path(@property)
        else
            render 'new'
        end
    end
    
    # GET /properties/:property_id/reports/:id/edit(.:format)
    def edit
    end
    
    
    # PATCH || PUT  /properties/:property_id/reports/:id(.:format)
    def update
        debugger
        if !params[:report][:file].nil?
            @new_report = @property.reports.new(report_params)
            if @new_report.save
                @report.destroy
                flash[:success] = "Report was successfully updated"
                redirect_to property_path(@property)
            else
                render 'edit'
            end
        else
            if @report.update(report_params)
                flash[:success] = "Report was successfully updated"
                redirect_to property_path(@property)
            else
                render 'edit'
            end
        end
        
        #if @report.update(report_params)\
#        debugger
#        if @new_report.save
#            @report.destroy
#            flash[:success] = "Report was successfully updated"
#            redirect_to property_path(@property)
#        else
#            render 'edit'
#        end
    end

    # DELETE /properties/:property_id/reports/:id(.:format)
    def destroy
        @report.destroy
        flash[:danger] = "Property was successfully deleted"
        redirect_to property_path(@property)
    end
    
    private 
        def report_params
            params.require(:report).permit(:file,:title,:year)
        end
        
        def set_report
            @report = Report.find(params[:id])
        end
        def set_property
            @property = Property.find(params[:property_id])
        end
end