class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @reports = Report.all
  end
  
  def update
    @report = Report.find(params[:id])
    @report.update(checked: true)
    flash[:notice] = "確認済みに更新しました"
    redirect_to admin_top_path
  end
end
