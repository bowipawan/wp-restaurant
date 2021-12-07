class AppointmentsController < ApplicationController
  include MainConcern

  before_action :set_appointment, only: %i[ show edit update destroy delete ]
  before_action :check_login, only: %i[ makeappointment submitappointment delete ]
  before_action :set_user, only: %i[ makeappointment submitappointment delete ]

  def makeappointment
    @restaurant = Restaurant.find_by(restaurant_name:params[:restaurant_name])
    @tables = @restaurant.tables.map { |table|
      [table,
        table.appointments.where(time_start: Date.today.all_day).map { |app| app[:time_start].hour()}
      ] }.to_h
    @appointment = Appointment.new
  end

  def submitappointment
    @table = Table.find_by(table_number:params[:table_number])
    @restaurant = Restaurant.find_by(restaurant_name:params[:restaurant_name])
    if(params[:commit]=='Confirm')
      @appointment = Appointment.new(appointment_params)
      @appointment.save
      redirect_to showrestaurant_path(@restaurant.restaurant_name), notice: "You have booked #{@restaurant.restaurant_name}."
    else
      redirect_to showrestaurant_path(@restaurant.restaurant_name)
    end
  end

  def delete
    @appointment.destroy
    redirect_to home_url, notice: "Appointment was successfully destroyed."
  end

  # GET /appointments or /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: "Appointment was successfully created." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: "Appointment was successfully updated." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:user_id, :table_id, :time_start, :people_amount)
    end
end
