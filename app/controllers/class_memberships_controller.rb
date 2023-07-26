class ClassMembershipsController < ApplicationController
  def create
    @classmembership = ClassMembership.new(class_membership_params)
    @classmembership.subject = Subject.find(params[:subject_id])
    if @classmembership.save
      redirect_to subject_path(@classmembership.subject)
    else
      render "subjects/show"
    end
  end

  def destroy
    # destroys a student with their class
    @classmembership = ClassMembership.find(params[:id])
    @classmembership.destroy
    redirect_to subject_path(@classmembership.subject)
  end

  private

  def class_membership_params
    params.require(:class_membership).permit(:user_id)
  end
end
