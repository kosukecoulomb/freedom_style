class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @reports = Report.all..order(created_at: :desc).where(checked: false)
  end
  
end
