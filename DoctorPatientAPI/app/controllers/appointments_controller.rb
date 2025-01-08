# app/controllers/appointments_controller.rb
class AppointmentsController < ApplicationController
    before_action :set_appointment, only: [:show, :update, :destroy]
  
    def index
      @appointments = Appointment.includes(:doctor, :patient).upcoming
      render json: @appointments
    end
  
    def show
      render json: @appointment
    end
  
    def create
      @appointment = Appointment.new(appointment_params)
      if @appointment.save
        render json: @appointment, status: :created
      else
        render json: @appointment.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @appointment.update(appointment_params)
        render json: @appointment
      else
        render json: @appointment.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @appointment.destroy
      head :no_content
    end
  
    private
  
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end
  
    def appointment_params
      params.require(:appointment).permit(:doctor_id, :patient_id, :appointment_date)
    end
  end
  