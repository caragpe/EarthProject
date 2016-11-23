class ReportsController < ApplicationController
    before_action :set_property, except: [:show]
    before_action :set_report, only: [:show, :edit, :update, :destroy]
    
    # GET /properties/:property_id/reports
    def index
        @property = Property.find(params[:property_id])
        @reports = @property.reports
    end
    
    # GET /properties/:property_id/reports/1
    def show
      send_data(@report.file_contents, type: @report.content_type, filename: @report.filename)
    end

    # GET /reports/new
    def new
        @report = @property.reports.new
    end
    
    # POST /reports
    def create
        @report = @property.reports.new(report_params)
        
        if @report.save
            flash[:success] = "Report was successfully uploaded"
            redirect_to property_path(@property)
        else
            render 'new'
        end
    end
    

    def update
    
    end

    def destroy
    
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