class Web::Admin::ReportsController < Web::Admin::ApplicationController
  before_action :set_report, except: :index

  # GET /reports
  def index
    @reports = Report.all
  end

  # DELETE /reports/1
  def destroy
    ReportsService.destroy(@report)
    redirect_to admin_reports_url, notice: 'Report was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

end
