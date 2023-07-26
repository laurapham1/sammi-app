class EmotionsController < ApplicationController
  def index
    @emotions = policy_scope(Emotion)
  end

  def new
    @emotion = Emotion.find(params[:id])
    authorize @emotion
  end
end
