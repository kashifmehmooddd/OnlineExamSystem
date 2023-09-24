# README


PROJECT: Online Exam System
A online examination app, where there are three types of users i.e, teachers, students, admin. A teacher can create an exam at a time and send for the approval to admin, admin can approve the exam, see all the pending exams, approved and finished exams, a student can attempt exams after the exam's start time and can see the breakdown of scores.

* TECHNOLOGIES:

    - Ruby 2.7
    - Rails 5.2

* Devise Authentication and devise invitable

    1. Admin can login and signup.
    2. Admin can send invite to other users.
    3. Invited users can select their role i.e, teacher or student and can set up their profile along with their profile picture.
    Invited users:

    has_one_attached :avatar, has_many :exams, through: :student_scores, has_many :questions, through: :user_answers

* Subjects
  Subjects can only be created by admin handled by policy.

  has_many: Exams.

* Exams
  Exams can only be created by the teacher and will be approved by the admin and can only be attempted by the student in a given time.

  belongs_to :subject has_many :questions, dependent: :destroy, has_many :students, through: :student_scores,
  belongs_to :teacher

* Student Score
  1. All the exams attempted by the students will be stored here.
  2. student can see only their own score.
  3. Teachers can see the score of the exams which are created by them.
  4. Admin can see the all attempted exams along with the student name.

    belongs_to :student, belongs_to :exam


* Questions

  1. All the questions for the exams will be stored here.
  2. These questions will also be used for storing the attempted user with their ids.

  belongs_to :exam, has_many :students, through: :user_answers, has_many :options,  dependent: :destroy

* options

  1. options will be used for the mcq based question.
  2. options will be stored along with the question id.

  belongs_to :question

* User Answers

  1. All the attempted questions by the specific students will be stored here.
  2. This model will also be used to show the breakdown of scores to all the users as the exam score.

  belongs_to :question, belongs_to :student

  End
