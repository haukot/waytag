class Web::Admin::ReportsController < Web::Admin::ApplicationController
  before_action :set_report, except: :index

  def good
    Classifier.train(@report.clean_text, :good)

    @report.try_approve!

    redirect_to :action => :index
  end

  def bad
    Classifier.train(@report.clean_text, :bad)

    @report.try_approve!

    redirect_to :action => :index
  end

  def publish
    @report.approve

    Classifier.train(@report.clean_text, :good)

    PostWorker.perform_async(@report.id)

    redirect_to :action => :index
  end

  # GET /reports
  def index
    query = params[:q] || { s: "time desc" }
    @search = Report.ransack query
    @reports = @search.result.page(params[:page]).decorate
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
