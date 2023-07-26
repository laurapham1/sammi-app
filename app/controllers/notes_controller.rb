class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.teacher = current_user
    @subject = Subject.find(params[:subject_id])
    @student = User.find(params[:user_id])
    @note.student = User.find(params[:user_id])
    authorize @note
    if @note.save
      respond_to do |format|
        format.html { redirect_to subject_user_path(Subject.find(params[:subject_id]), @note.student) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'users/show' }
        format.js
      end
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to subject_user_path(Subject.find(params[:subject_id]), @note.student)
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end
