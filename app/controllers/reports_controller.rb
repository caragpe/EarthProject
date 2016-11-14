class ReportsController < ApplicationController
    before_action :set_report, only: [:show, :edit, :update, :destroy]
    
    # GET /reports
    def index
        @report = Report.all
    end
    
    # GET /reports/1
    def show
      send_data(@report.file_contents, type: @report.content_type, filename: @report.filename)
    end

    # GET /reports/new
    def new
        @report = Report.new
    end
    
    # POST /reports
    def create
        
    end
    

    def update
    
    end

    def destroy
    
    end
    
    private 
        def report_params
            params.require(:report).permit(:file)
        end
        
        def set_report
            @report = Report.find(params[:id])
        end
end