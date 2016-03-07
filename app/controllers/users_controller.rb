class UsersController < ApplicationController
  def show
    @lectures = current_user.lectures.page(params[:page]).per(10).order('id DESEC')
  end

  def edit
  end

  def update
  end
  
end
