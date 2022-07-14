class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reports = Report.includes(:comment).all.order(created_at: :desc)
  end

  def update
    @report = Report.find(params[:id])
    if @report.checked == false
      @report.update(checked: true)
    else
      @report.update(checked: false)
    end
    @reports = Report.includes(:comment).all.order(created_at: :desc)
  end
  
  def checked
    @report = Report.find(params[:id])
    @report.update(checked: true)
    @reports = Report.includes(:comment).order(created_at: :desc).where(checked: false)
  end
end
