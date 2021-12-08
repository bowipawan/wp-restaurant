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
    @restaurant = Restaurant.find_by(restaurant_name:params[:restaurant_name])
    if(params[:commit]=='Back')
      redirect_to showrestaurant_path(@restaurant.restaurant_name)
    else
      if (params[:other][:people] == "")
        redirect_to makeappointment_path(@restaurant.restaurant_name), alert: "Please fill people amount."
      else
        @people_amount = params[:other][:people].to_i
        @time_start = DateTime.now.change({ hour: params[:other][:time].to_i+7, min: 0, sec: 0 })
        @table = Table.find_by(table_number:params[:other][:table_number],restaurant_id:@restaurant.id)
        if (Appointment.find_by(table_id:@table.id,time_start:@time_start) != nil)
          redirect_to makeappointment_path(@restaurant.restaurant_name), alert: "Your chosen table is full at that time. Please choose other table."
        elsif (@people_amount > @table.customer_cap)
          redirect_to makeappointment_path(@restaurant.restaurant_name), alert: "Your people amount exceed table capacity. Please choose other table."
        else
          @appointment = Appointment.new
          @appointment.user_id = @user.id
          @appointment.table_id = @table.id
          @appointment.time_start = @time_start
          @appointment.people_amount = @people_amount
          if @appointment.save
            redirect_to home_path, notice: "You have booked #{@restaurant.restaurant_name}."
          else
            redirect_to makeappointment_path(@restaurant.restaurant_name), alert: "Something went wrong. Please try again."
          end
        end
      end
    end
  end

  def delete
    @appointment.destroy
    redirect_to home_url, notice: "You have canceled appointment."
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
