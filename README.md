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

screenshots
<img width="1440" alt="Screenshot 2023-09-24 at 12 29 41 PM" src="https://github.com/kashifmehmooddd/OnlineExamSystem/assets/101459306/6f733dc2-9dcd-4601-9ee5-04f0fa7a5c88">
<img width="1440" alt="Screenshot 2023-09-24 at 12 29 38 PM" src="https://github.com/kashifmehmooddd/OnlineExamSystem/assets/101459306/644830cb-a835-400e-b333-9b7ca6603850">
<img width="1440" alt="Screenshot 2023-09-24 at 12 29 17 PM" src="https://github.com/kashifmehmooddd/OnlineExamSystem/assets/101459306/6a22e6aa-39fe-40b8-8ab5-f92794d832b3">
<img width="1440" alt="Screenshot 2023-09-24 at 12 29 01 PM" src="https://github.com/kashifmehmooddd/OnlineExamSystem/assets/101459306/3746d1cc-dff8-42fd-b78f-bec445ac5853">
<img width="1440" alt="Screenshot 2023-09-24 at 12 27 20 PM" src="https://github.com/kashifmehmooddd/OnlineExamSystem/assets/101459306/f240b673-8f32-4ac6-8c99-3a57d83d9137">
<img width="1440" alt="Screenshot 2023-09-24 at 12 26 55 PM" src="https://github.com/kashifmehmooddd/OnlineExamSystem/assets/101459306/f528cda5-df15-4749-a95f-b364005361f0">
<img width="1440" alt="Screenshot 2023-09-24 at 12 26 24 PM" src="https://github.com/kashifmehmooddd/OnlineExamSystem/assets/101459306/4a423dc5-896a-4d59-8e7a-15776e0d2d12">
<img width="1440" alt="Screenshot 2023-09-24 at 12 26 11 PM" src="https://github.com/kashifmehmooddd/OnlineExamSystem/assets/101459306/68863f1f-31bf-4fc2-b379-6731a44cae3e">
<img width="1440" alt="Screenshot 2023-09-24 at 12 24 46 PM" src="https://github.com/kashifmehmooddd/OnlineExamSystem/assets/101459306/afb5955a-73ef-49d3-b296-587b22e5aae7">
<img width="1440" alt="Screenshot 2023-09-24 at 12 24 32 PM" src="https://github.com/kashifmehmooddd/OnlineExamSystem/assets/101459306/1e12cb15-1eba-4db8-b7de-dd7ef095c3a6">
