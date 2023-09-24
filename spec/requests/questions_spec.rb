require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let!(:teacher) { create(:teacher) }
  let!(:admin) { create(:admin) }
  let!(:exam) { create(:exam) }

  describe 'GET /index' do
    context 'when user want to see all the questions' do
      before do
        sign_in teacher
      end

      let!(:questions) { create_list(:question, 3, exam_id: exam.id) }

      it 'is expected to show all questions of an exams' do
        get exam_questions_url(exam)
        expect(assigns[:questions].length).to be(3)
        expect(response).to be_successful
      end
    end

    context 'when user visits exams questions without signing in' do
      it 'is expected to redirect to sign in page', :logged_out do
        get exam_questions_url(exam)
        expect(response).to redirect_to(user_session_url)
      end
    end
  end

  describe 'GET #new' do
    context 'when teacher makes the new question for an exam' do
      before do
        sign_in teacher
      end

      it 'is expected to assign question as new instance variable' do
        get new_exam_question_path(exam.id)
        expect((assigns[:question])).to be_instance_of(Question)
        expect(response).to be_successful
        expect(subject).to render_template(:new)
      end
    end

    context 'when admin/student tries to make new question for an exam' do
      before do
        sign_in admin
      end

      it 'is expected to assign question as new instance variable' do
        get new_exam_question_path(exam.id)
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end
  end

  describe 'POST #create' do
    before do
      sign_in teacher
    end

    context 'when teacher create text-based question with valid data' do
      let(:params) do
        { question:
             { description: 'What is AI',
               exam_id: exam.id,
               answer: 'Artificial Intelligence',
               score: 2,
               base: 'text' } }
      end

      it 'is expected create exam with valid exams params' do
        post exam_questions_path(exam.id), params: params
        expect(assigns[:question]).to be_valid
      end
    end

    context 'when teacher create text-based question with invalid data' do
      let(:params) do
        { question:
             { description: '',
               exam_id: exam.id,
               answer: 'Artificial Intelligence',
               score: 2,
               base: 'text' } }
      end

      it 'is expected create exam with valid exams params' do
        post exam_questions_path(exam.id), params: params
        expect(assigns[:question]).not_to be_valid
        expect(flash[:alert]).to eq("Description can't be blank")
      end
    end

    context 'when teacher create MCQ-based question with valid data' do
      let(:params) do
        { question:
             { description: 'What is AI',
               exam_id: exam.id,
               answer: '2',
               score: 2,
               base: 'MCQ',
               opts: %w[false true false false] } }
      end

      it 'is expected create exam with valid exams params' do
        post exam_questions_path(exam.id), params: params
        expect(assigns[:question]).to be_valid
        expect(assigns[:question].base).to eq('MCQ')
      end
    end

    context 'when teacher create MCQ-based question with invalid data' do
      let(:params) do
        { question:
             { description: '',
               exam_id: exam.id,
               answer: '6',
               score: 2,
               base: 'MCQ',
               opts: %w[false true false false] } }
      end

      it 'is expected create exam with valid exams params' do
        post exam_questions_path(exam.id), params: params
        expect(assigns[:question]).not_to be_valid
        expect(flash[:alert]).to eq("Description can't be blank, Answer  should be in the option numbers")
      end
    end
  end

  describe 'DELETE #delete' do
    let(:question) { FactoryBot.create(:question, exam_id: exam.id) }
    context 'when teacher deletes an exams question' do
      it 'is expected to destroy that question of an exam' do
        sign_in teacher
        delete exam_question_url(exam.id, question.id)
        expect(Question.find_by(id: question.id)).to be_nil
        expect(flash[:notice]).to eq('Question has been deleted')
        expect(response).to redirect_to(exam_path(exam.id))
      end
    end
  end
end
