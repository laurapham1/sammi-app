class SubjectsController < ApplicationController
  def index
    @subjects = policy_scope(Subject)
    @subject = Subject.new
    @emotions_hash = {}
    @subjects.each do |subject|
      @emotions_hash[subject.id] = subject.class_members.map { |stu| stu.daily_emotions.first.emotion.number }
    end
    # emotions_map = Subject.first.class_members.map { |stu| stu.daily_emotions.first.emotion.number }
    @emotions_hash = @emotions_hash.map do |k, v|
      [k, v.group_by{|r| r}]
    end

    @emotions_hash = @emotions_hash.to_h

    @emotions_hash = @emotions_hash.map do |k, v|
      [k, v.map { |k, v| [k, v.length] }.to_h]
    end

    @emotions_hash.map! do |subject|
      [subject[0], subject[1].map{ |k, v| [k, v.to_f / subject[1].values.inject(:+)] }.to_h]
    end

    @hsh = {}
    @emo_array = @emotions_hash.map{|subject|subject[1]}.map{|h|h.map{|k, v|k*v}.sum}

    counter = 0
    @subjects.each do |subject|
      @hsh[subject.id] = @emo_array[counter]
      counter +=1
      # @emo_array.each do |emo|
      #   @hsh[subject.id] = emo
      # end

    end

    @avergae_hash = {}


    # grouped_emotions = emotions_map.group_by{|r| r}
    # length = emotions_map.length
    # count_emos = grouped_emotions.map { |key, value| { key => value.length } }
    # @emo_index = count_emos.map { |i| i.map { |key, value| { key => (value / length.to_f) * 100 } } }.map { |i| i.first }.reduce Hash.new, :merge
    # @emo_average = @emo_index.map {|k, v| k * v }.sum / 100
    # raise

    @random_proportions =
      { 2 => [25, 20, 35, 10, 10],
        5 => [10, 10, 10, 5, 65],
        3 => [8, 52, 15, 5, 20],
        4 => [10, 10, 10, 20, 50],
        4.5 => [13, 27, 20, 30, 30] }
  end

  def show
    @subject = Subject.find(params[:id])
    emotion_map = @subject.class_members.map {|student| student.daily_emotions.first.emotion.number }
    grouped_emotions = emotion_map.group_by{|r| r}
    length = emotion_map.length
    count_emos = grouped_emotions.map { |key, value| { key => value.length } }
    @emo_prop = count_emos.map { |i| i.map { |key, value| { key => (value / length.to_f) * 100 } } }.map { |i| i.first }.reduce Hash.new, :merge
    @emo_average = @emo_prop.map { |k, v| k * v }.sum / 100
    authorize @subject
  end

  def new
    @user = current_user
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.user = current_user
    authorize @subject
    if @subject.save
      redirect_to subjects_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    authorize @subject
    redirect_to subjects_path
  end

  def subject_params
    params.require(:subject).permit(:name, :room, :photo)
  end
end
