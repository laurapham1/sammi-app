class DailyEmotionsController < ApplicationController
  def create
    @daily_emotion = DailyEmotion.new(daily_emotion_params)
    @daily_emotion.user = current_user
    authorize @daily_emotion
    if @daily_emotion.save
      redirect_to root_path
    else
      render "pages/home"
    end
  end

  def destroy
    @daily_emotion = daily_emotion.find(params[:id])
    @daily_emotion.destroy
    redirect_to daily_emotions_path
  end

  def new
    @daily_emotion = DailyEmotion.new
    authorize @daily_emotion
  end

  private

  def daily_emotion_params
    params.require(:daily_emotion).permit(:emotion_id)
  end
end
