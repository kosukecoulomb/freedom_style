class Public::HomesController < ApplicationController
  def top
    @user = current_user
  end

  def about
  end
end
