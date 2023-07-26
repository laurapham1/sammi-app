class AppointmentsController < ApplicationController
  def index
    if current_user.teacher
      @completed_appointments = policy_scope(Appointment).where(teacher: current_user, completed: true)
      @pending_appointments = policy_scope(Appointment).where(teacher: current_user, completed: false)
    else
      @completed_appointments = policy_scope(Appointment).where(student: current_user, completed: true)
      @pending_appointments = policy_scope(Appointment).where(student: current_user, completed: false)
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.teacher = current_user
    @appointment.student = User.find(params[:user_id])
    authorize @appointment
    if @appointment.save
      redirect_to appointments_path
    else
      render "users/show"
    end
  end


  def update
    @appointment = Appointment.find(params[:id])
    authorize @appointment
    if @appointment.update(appointment_params)
      redirect_to appointments_path
    else
      flash[:alert] = "oh no something went wrong"
      redirect_to appointments_path
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    authorize @appointment
    @appointment.destroy
    redirect_to appointments_path
  end

  private

  def appointment_params
    params.require(:appointment).permit(:comment, :date, :student, :completed)
  end
end
