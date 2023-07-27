
puts 'Cleaning database...'

ClassMembership.destroy_all
Appointment.destroy_all
DailyEmotion.destroy_all
Subject.destroy_all
Emotion.destroy_all
User.destroy_all

#Users
# 1 teacher and 20 students
puts 'Creating Users...'
teacher_user = User.create!(first_name: 'Kate', last_name: 'Haywood', email: 'khaywood@teacher.com', password: '123123', photo: "teacher1.jpeg", role: 'teacher' )
teacher_user2 = User.create!(first_name: 'Miles', last_name: 'Hoffman', email: 'mhoffman@teacher.com', password: '123123', photo: "teacher2.jpeg", role: 'teacher' )
teacher_user3 = User.create!(first_name: 'Ally', last_name: 'Perry', email: 'aperry@teacher.com', password: '123123', photo: "teacher3.jpeg", role: 'teacher' )

main_student = User.create!(first_name: 'Jamie', last_name: 'Smith', email: 'jsmith@student.com', password: '123123', photo: "male1.jpeg", role: 'teacher')

female_students = []
female_count = 1

10.times do
  female_students << User.create!(first_name: Faker::Name.female_first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: '123123', role: 'student', photo: "female" + female_count.to_s + ".jpeg")
  female_count += 1
end

male_students = []
male_count = 2

10.times do
  male_students << User.create!(first_name: Faker::Name.female_first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: '123123', role: 'student', photo: "male" + male_count.to_s + ".jpeg")
  male_count += 1
end

students_array = male_students + female_students

#Emotions
# establish emotions rating system
puts 'Creating Emotions...'
Emotion.create!(rating: 1)
Emotion.create!(rating: 2)
Emotion.create!(rating: 3)
Emotion.create!(rating: 4)
Emotion.create!(rating: 5)

#Subjects
# 6 subjects for the 1 teacher
puts 'Creating Subjects...'

main_subject = Subject.create!(name: "9C Science", photo: "science3.png", user: teacher_user )
subject2 = Subject.create!(name: "8A Science", photo: "science1.png", user: teacher_user )
subject3 = Subject.create!(name: "11B Science", photo: "science2.png", user: teacher_user )
subject4 = Subject.create!(name: "7A Math", photo: "math1.png", user: teacher_user )
subject5 =Subject.create!(name: "8B Math", photo: "math2.png", user: teacher_user )
subject6 = Subject.create!(name: "8C Science", photo: "math3.png", user: teacher_user )

#Daily Emotions
# 19 students with one emotion
# 1 student with emotion history for 2 months
puts 'Creating Daily Emotions...'
student_emotion_array = []

low_emotion_range = Emotion.all.slice(0,3)

15.times do
  student_emotion_array << DailyEmotion.create!(emotion: low_emotion_range.sample, user: main_student)
end

positive_emotion_range = Emotion.all.slice(2,3)
45.times do
  student_emotion_array << DailyEmotion.create!(emotion: positive_emotion_range.sample, user: main_student)
end

count = 0
student_emotion_array.each do |emotion|
  emotion.created_at = DateTime.new(2019,12,6) - count
  count += 1
  emotion.save
end

students_array.each do |student|
  de = DailyEmotion.create!(emotion: Emotion.all.sample, user: student)
  de.created_at = DateTime.new(2019,12,6)
  de.save
end

students_array.each do |student|
  fe = DailyEmotion.create!(emotion: Emotion.all.sample, user: student)
  fe.created_at = DateTime.new(2019,12,5)
  fe.save
end




#Appointments
# 3 upcoming appointments, 2 past appointments
puts 'Creating Appointments...'

Appointment.create!(student: students_array[0], teacher: teacher_user, date: DateTime.new(2019,12,10,8,30))
Appointment.create!(student: students_array[1], teacher: teacher_user, date: DateTime.new(2019,12,9,13))
Appointment.create!(student: students_array[2], teacher: teacher_user, date: DateTime.new(2019,12,6,13))
Appointment.create!(student: students_array[3], teacher: teacher_user, date: DateTime.new(2019,11,25,15,30), completed: true)
Appointment.create!(student: students_array[4], teacher: teacher_user, date: DateTime.new(2019,11,20,8,30), completed: true)

# Class Memberships
# add all students to Year 9 Science subject
puts 'Creating Class Memberships...'
# main subject class
students_array.sample(13).each do |student|
  ClassMembership.create!(user: student, subject: main_subject)
end

ClassMembership.create!(user: main_student, subject: main_subject)

# subject2
students_array.sample(rand(10..17)).each do |student|
  ClassMembership.create!(user: student, subject: subject2)
end

# subject3
students_array.sample(rand(10..17)).each do |student|
  ClassMembership.create!(user: student, subject: subject3)
end

# subject4
students_array.sample(rand(10..17)).each do |student|
  ClassMembership.create!(user: student, subject: subject4)
end

# subject5
students_array.sample(rand(10..17)).each do |student|
  ClassMembership.create!(user: student, subject: subject5)
end

# subject6
students_array.sample(rand(10..17)).each do |student|
  ClassMembership.create!(user: student, subject: subject6)
end


# Notes
puts 'Creating Teacher Notes'
note1 = Note.new(student: main_student, teacher: teacher_user2, content: "Jamie had some family issues this week. Expect his mood to be lower than usual.")
note2 = Note.new(student: main_student, teacher: teacher_user3, content: "Jamie was disengaged and refused to complete work in English class today. I have called home and his parents are also concerned.")

note1.created_at = DateTime.new(2019,12,4,15,15)
note2.created_at = DateTime.new(2019,12,5,15,27)

note1.save
note2.save

puts 'Finished!'
