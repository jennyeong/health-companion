class RemindersController < ApplicationController
  before_action :set_reminder, only: %i[ show edit update destroy ]

  # GET /reminders or /reminders.json
  def index
    @reminders = Reminder.all
  end

  # GET /reminders/1 or /reminders/1.json
  def show
  end

  # GET /reminders/new
  def new
    @reminder = Reminder.new
  end

  # GET /reminders/1/edit
  def edit
  end

  # POST /reminders or /reminders.json
  def create
    @reminder = Reminder.new(reminder_params)

    respond_to do |format|
      if @reminder.save
        format.html { redirect_to reminder_url(@reminder), notice: "Reminder was successfully created." }
        format.json { render :show, status: :created, location: @reminder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reminders/1 or /reminders/1.json
  def update
    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to reminder_url(@reminder), notice: "Reminder was successfully updated." }
        format.json { render :show, status: :ok, location: @reminder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1 or /reminders/1.json
  def destroy
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to reminders_url, notice: "Reminder was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reminder_params
      params.fetch(:reminder, {}).permit(:id, :interval, :start_date, :end_date, :start_time, :end_time, :dosage, :med_name, :description, :user_id, :medicine_id)
    end
end
