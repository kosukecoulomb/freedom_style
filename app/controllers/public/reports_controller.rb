class Public::ReportsController < ApplicationController
  before_action :authenticate_user!

  def create
    @report = Report.new(report_params)
    @report.reporting_id = current_user.id
    @report.save
    flash[:notice] = "管理者に通報しました"
  end
  
  private

  def report_params
    params.permit(:reporting_id, :comment_id, :checked)
  end
end
