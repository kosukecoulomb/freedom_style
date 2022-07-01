class Public::ReportsController < ApplicationController
  
  def create
    @report = Report.new(report_params)
    @report.save
    flash[:notice] = "管理者に通報しました"
  end
  
  private
  
  def report_params
    params.require(:report).permit(:comment_id, :coordinate_id, :user_id, :detail, :report_class, :checked)
  end
end
