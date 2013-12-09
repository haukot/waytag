class Web::Admin::ReportsController < Web::Admin::ApplicationController
  before_action :set_report, except: :index

  def perform
    f(:success)

    ReportsService.perform @report.id

    redirect_to action: :index
  end

  def good
    Classifier.train(@report.clean_text, :good)

    f(:success)

    redirect_to action: :index
  end

  def bad
    Classifier.train(@report.clean_text, :bad)

    @report.try_approve!

    f(:success)

    redirect_to action: :index
  end

  def publish
    @report.approve

    Classifier.train(@report.clean_text, :good)

    PostWorker.perform_async(@report.id)

    f(:success)

    redirect_to action: :index
  end

  def index
    query = params[:q] || { s: "time desc" }
    @search = Report.ransack query
    @reports = @search.result.page(params[:page]).includes([:city, :sourceable]).decorate
  end

  def destroy
    ReportsService.destroy(@report)

    f(:success)

    redirect_to admin_reports_url
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end
end
