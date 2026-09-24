class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show]
  before_action :set_my_room, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:keyword].present?
      @rooms = @rooms.where(
        "name LIKE ? OR description LIKE ?",
        "%#{params[:keyword]}%",
        "%#{params[:keyword]}%"
      )
    end
  end

  def my_rooms
    @rooms = current_user.rooms
  end

  def show
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to my_rooms_path, notice: "施設を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to my_rooms_path, notice: "施設を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to my_rooms_path, status: :see_other, notice: "施設を削除しました"
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def set_my_room
    @room = current_user.rooms.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
