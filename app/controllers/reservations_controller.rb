class ReservationsController < ApplicationController
  def index 
    if user_signed_in?
      @reservations = current_user.reservations.where("reservation_date >= ?", Date.today)
    else
      redirect_to new_user_session_path, notice: "ログインしてください"
    end
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.save
      redirect_to reservations_path, notice: "予約が完了しました"
    else
      render :new, notice: "予約に失敗しました"
    end
  end

  def show
    if @reservation.user_id != current_user.id
      redirect_to reservations_path, notice: "他人の予約は見れません"
    end
    @reservation = current_user.reservations.all
  end

  def edit 
    @reservation = Reservation.find(params[:id])
    if @reservation.user_id != current_user.id
      redirect_to reservations_path, notice: "他人の予約は編集できません"
    end

    if @reservation.reservation_date < Date.today
      redirect_to reservations_path, notice: "過去の予約は編集できません"
    end

  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: "予約を更新しました"
    else
      render :edit, notice: "予約の更新に失敗しました"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.user_id != current_user.id
      redirect_to reservations_path, notice: "他人の予約は削除できません"
    end

    if @reservation.reservation_date < Date.today
      redirect_to reservations_path, notice: "過去の予約は削除できません"
    end

    if @reservation.destroy
      redirect_to reservations_path, notice: "予約を削除しました"
    else
      redirect_to reservations_path, notice: "予約の削除に失敗しました"
    end
  end

  private
  
  def reservation_params
    params.require(:reservation).permit(:reservation_date)
  end
end
