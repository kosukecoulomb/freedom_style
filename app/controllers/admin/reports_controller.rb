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
    flash[:notice] = "ステータスを更新しました"
    redirect_to request.referer
  end
end
