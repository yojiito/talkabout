class LecturesController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
   @lectures = Lecture.includes(:user).order('id DESC').page(params[:page]).per(20)
  end

  def search
    @lectures = Lecture.where('title LIKE(?)',"%#{params[:keyword]}%").order('id DESC').page(params[:page]).per(10)
  end

  def show
    @lecture = Lecture.find(params[:id])
  end

  def new
    @lecture = Lecture.new
  end

  def create
    Lecture.create(create_params)
  end

  def destroy
    lecture = Lecture.find(params[:id])
    if lecture.user_id == current_user.id
    lecture.destroy
    end
  end

  def edit
    @lecture = Lecture.find(params[:id])
  end

    def update
      lecture = Lecture.find(params[:id])
      if lecture.user_id == current_user.id
        lecture.update(update_params)
      end
    end

  private
  def create_params
    params.require(:lecture).permit(:title, :date, :place, :detail).merge(id: params[:id], user_id: current_user.id)
  end

 private
  def update_params
    params.permit(:title, :date, :place, :detail)
  end

end
