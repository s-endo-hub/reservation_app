class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:room).order(created_at: :desc)
  end

  def new
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room

    if @reservation.valid?
      @nights = (@reservation.checkout_at - @reservation.checkin_at).to_i
      @total_price = @room.price * @nights * @reservation.guest_count

      render :confirm
    else
      render :new, status: :unprocessable_entity
    end
  end

  def complete
    @room = Room.find(params[:room_id])

    @reservation = current_user.reservations.build(
      checkin_at: params[:checkin_at],
      checkout_at: params[:checkout_at],
      guest_count: params[:guest_count]
    )

    @reservation.room = @room

    if @reservation.save
      redirect_to reservations_path, notice: "予約が完了しました"
    else
      redirect_to new_room_reservation_path(@room), alert: "予約に失敗しました"
    end
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy

    redirect_to reservations_path, notice: "予約を削除しました", status: :see_other
  end

  private

  def reservation_params
    params.require(:reservation).permit(:checkin_at, :checkout_at, :guest_count)
  end
end
