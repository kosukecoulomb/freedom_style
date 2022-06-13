class Public::TagsController < ApplicationController
  
  private
  
  def tag_params
    params.require(:user).permit(:tag_name)
  end
  
end
