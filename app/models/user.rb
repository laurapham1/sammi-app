class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :teacher_appointment_relationships, foreign_key: :teacher_id, class_name: 'Appointment'
         has_many :teacher_appointments, through: :teacher_appointment_relationships, source: :teacher
         has_many :student_appointment_relationships, foreign_key: :student_id, class_name: 'Appointment'
         has_many :student_appointments, through: :student_appointment_relationships, source: :student
         has_many :daily_emotions
         has_many :emotions, through: :daily_emotions
       
         has_many :teacher_note_relationships, foreign_key: :teacher_id, class_name: 'Note'
         has_many :teacher_notes, through: :teacher_note_relationships, source: :teacher
         has_many :student_note_relationships, foreign_key: :student_id, class_name: 'Note'
         has_many :student_notes, through: :student_note_relationships, source: :student
       
         has_many :subjects
         has_many :class_leaderships, through: :subjects, source: :class_membership
         has_many :students, through: :class_leaderships, source: :user
         has_many :class_memberships
         has_many :student_subjects, through: :class_memberships, source: :subject
         has_many :teachers, through: :student_subjects, source: :user
       
         validates :first_name, presence: true
         validates :last_name, presence: true
       
         has_many :teacher_note_relationships, foreign_key: :teacher_id, class_name: 'Note'
         has_many :student_note_relationships, foreign_key: :student_id, class_name: 'Note'
       
         scope :teachers, -> { where(teacher: true) }
         scope :students, -> { where(teacher: false) }
       
         # used to check if child has already submitted an emotion
         def has_submitted_today?
           daily_emotions.where(date: DateTime.today).any?
         end
       
end
