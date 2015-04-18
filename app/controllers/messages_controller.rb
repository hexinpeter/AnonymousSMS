class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # # GET /messages
  # # GET /messages.json
  # def index
  #   @messages = Message.all
  # end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # # GET /messages/1/edit
  # def edit
  # end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(to: message_params[:to],
                           content: message_params[:content],
                           time: param_utc_time)

    respond_to do |format|
      if @message.save
        # send the message by adding it to Sidekiq queue
        SendWorker.perform_in(schedule_time, token, @message.id)
        # SendWorker.new.perform(token, @message.id)

        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:to, :content, :time)
    end

    # the timezone offset in seconds
    def param_timezone_offset
      params[:timezone_offset].to_i * -60
    end

    def param_utc_time
      user_input_time = Time.new(message_params['time(1i)'].to_i,
                               message_params['time(2i)'].to_i,
                               message_params['time(3i)'].to_i,
                               message_params['time(4i)'].to_i,
                               message_params['time(5i)'].to_i,
                               0,
                               param_timezone_offset)
      user_input_time.utc
    end

    def token
      Token.get_token
    end

    def schedule_time
      param_utc_time - Time.now.utc > 0 ? (param_utc_time - Time.now.utc) : 0.minute
    end
end
