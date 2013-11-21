class ReportDecorator < Draper::Decorator
  delegate_all

  def state_class
    if object.posted?
      "success"
    elsif object.rejected? || object.bad?
      "warning"
    elsif object.post_failed?
      "danger"
    end
  end

end
