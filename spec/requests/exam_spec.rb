require 'rails_helper'

RSpec.describe 'Exams', type: :request do
  let!(:student) { create(:student) }
  let(:teacher) { create(:teacher) }
  let(:admin) { create(:admin) }
  let(:subject) { create(:subject) }

  describe 'Get #index' do
    context 'when user want to see incoming exams' do
      let!(:exams) { create_list(:exam, 3, status: 2) }

      it 'is expected to show all approved exams' do
        sign_in student
        get exams_url
        expect(assigns[:exams].length).to be(3)
        expect(subject).to render_template(:index)
        expect(response).to be_successful
      end
    end

    context 'when user visits incoming exams without signing in' do
      it 'is expected to redirect to sign in page', :logged_out do
        get exams_url
        expect(response).to redirect_to(user_session_url)
      end
    end
  end

  describe 'GET #new' do
    context 'when teacher makes the new exam' do
      it 'is expected to assign exam as new instance variable' do
        sign_in teacher
        get new_exam_url
        expect((assigns[:exam])).to be_instance_of(Exam)
        expect(response).to be_successful
        expect(subject).to render_template(:new)
      end
    end

    context 'when Admin/student visits a new exam page' do
      it 'is expected to show You are not authorized to perform this action.' do
        sign_in student
        get new_exam_url
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'when teacher has already one exam in progress' do
      let!(:exam) { create(:exam, teacher: teacher) }

      it 'is expected to assign exam as new instance variable' do
        sign_in teacher
        get new_exam_url
        expect(flash[:alert]).to eq('You have already one exam in progress!')
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'POST #create' do
    before do
      sign_in teacher
    end

    context 'when user create Exam with valid data' do
      let(:params) do
        { exam:
          { exam_code: 'exam-123',
            start_time: DateTime.now + (1/24r),
            end_time: DateTime.now + (2/24r),
            score: 0,
            subject_id: subject.id,
            teacher_id: teacher.id } }
      end

      it 'is expected create exam with valid exams params' do
        post exams_url, params: params
        expect(assigns[:exam])
        expect(assigns[:exam].exam_code).to eq('exam-123')
        expect(assigns[:exam].score).to eq(0)
        expect(assigns[:exam].subject_id).to eq(subject.id)
        expect(assigns[:exam].teacher_id).to eq(teacher.id)
      end
    end

    context 'when user create Exam with invalid data' do
      let(:params) do
        { exam:
         { exam_code: 'exam-123',
           start_time: DateTime.now + (1/24r),
           end_time: DateTime.now,
           score: 0,
           subject_id: subject.id,
           teacher_id: teacher.id } }
      end

      it 'is expected create exam with valid exams params' do
        post exams_url, params: params
        expect(assigns[:exam]).not_to be_valid
        expect(flash[:alert]).to eq('End time  should be after start time')
        expect(response).to redirect_to(new_exam_url)
      end
    end
  end

  describe 'PATCH #update' do
    let(:edit_exam) { create(:exam, teacher_id: teacher.id) }

    before do
      sign_in teacher
    end

    context 'when user update Exam with valid data' do
      let(:params) do
        { exam:
        { exam_code: 'exam-123',
          start_time: DateTime.now + (1/24r),
          end_time: DateTime.now + (2/24r),
          score: 0,
          subject_id: subject.id,
          teacher_id: teacher.id } }
      end

      it 'is expected create exam with valid exams params' do
        patch exam_url(edit_exam.id), params: params
        expect(assigns[:exam]).to eq(Exam.find_by(id: edit_exam.id))
        expect(assigns[:exam].exam_code).to eq('exam-123')
        expect(assigns[:exam].score).to eq(0)
        expect(assigns[:exam].subject_id).to eq(subject.id)
        expect(assigns[:exam].teacher_id).to eq(teacher.id)
      end
    end

    context 'when user update Exam with invalid data' do
      let(:params) do
        { exam:
       { exam_code: 'exam-123',
         start_time: DateTime.now,
         end_time: DateTime.now - (1/24r),
         score: 0,
         subject_id: subject.id,
         teacher_id: teacher.id } }
      end

      it 'is expected create exam with valid exams params' do
        patch exam_url(edit_exam.id), params: params
        expect(assigns[:exam]).not_to be_valid
        expect(flash[:alert]).to eq('Start time  should be after current time, End time  should be after start time')
        expect(response).to redirect_to(edit_exam_path(edit_exam))
      end
    end
  end

  describe 'GET #show' do
    context 'when user visits a specific exam' do
      let(:exam) { create(:exam) }

      it 'is expected to have instance of exam' do
        sign_in teacher
        get exam_url(exam)

        expect(response).to be_successful
        expect(subject).to render_template(:show)
      end
    end
  end

  describe 'PATCH #update_status' do
    let(:edit_exam_status) { create(:exam) }

    context 'when user update Exam with valid data' do
      let(:params) { { status: 'approved' } }

      it 'is expected create exam with valid exams params' do
        sign_in teacher
        patch update_status_exam_path(edit_exam_status.id), params: params
        expect(response).to redirect_to(assigns[:exam])
      end
    end
  end

  describe 'PATCH #restart_exam' do
    let(:exam) { create(:exam) }

    context 'when user update Exam with valid data' do
      it 'is expected create exam with valid exams params' do
        sign_in student
        patch restart_exam_exam_path(exam.id)
        expect(response).to redirect_to(new_exam_user_answer_path(exam.id))
      end
    end
  end

  describe 'DELETE #delete' do
    let(:exam) { create(:exam) }

    context 'when user deletes an exam' do
      it 'is expected to destroy the Exam' do
        sign_in teacher
        delete exam_url(exam.id)
        expect(Exam.find_by(id: exam.id)).to be_nil
        expect(flash[:notice]).to eq("Exam #{exam.exam_code} has been deleted!")
        expect(response).to redirect_to(exams_path)
      end
    end
  end

  describe 'Get #finished' do
    context 'when Teacher wants to see finished exams' do
      before do
        sign_in teacher
      end

      let!(:exams) { create_list(:exam, 3, :approved, teacher_id: teacher.id) }

      it 'is expected to show all finished exams created by the loged in teacher' do
        exams.each do |exam|
          exam.end_time = DateTime.now - (1 / 24)
          exam.save(validate: false)
        end
        get finished_exams_url
        expect(assigns[:exams].length).to be(3)
        expect(subject).to render_template(:finished)
        expect(response).to be_successful
      end
    end

    context 'when Student or Admin wants to see finished exams' do
      before do
        sign_in student
      end

      let!(:exams) { create_list(:exam, 3, :approved) }

      it 'is expected to show all finished exams created by the loged in teacher' do
        exams.each do |exam|
          exam.end_time = DateTime.now - (1 / 24)
          exam.save(validate: false)
        end
        get finished_exams_url
        expect(assigns[:exams].length).to be(3)
        expect(subject).to render_template(:finished)
        expect(response).to be_successful
      end
    end
  end

  describe 'Get #pendings' do
    context 'when Admin wants to see pending exams for approval' do
      let!(:exams) { create_list(:exam, 3, :ready) }

      it 'is expected to show all finished exams created by the loged in teacher' do
        sign_in admin
        get pendings_exams_path
        expect(assigns[:exams].length).to be(3)
        expect(subject).to render_template(:pendings)
        expect(response).to be_successful
      end
    end

    context 'when other users wants to see pending exams for approval' do
      let!(:exams) { create_list(:exam, 3, :ready) }

      it 'is expected to show all finished exams created by the loged in teacher' do
        sign_in student
        get pendings_exams_path
        expect(assigns[:exams].length).to be(0)
      end
    end
  end

  describe 'Get #creations' do
    context 'when Teachers wants to see exam in progress for approval' do
      let!(:exams) { create(:exam, teacher_id: teacher.id) }

      it 'is expected to show all finished exams created by the loged in teacher' do
        sign_in teacher
        get creations_exams_path
        expect(assigns[:exams].length).to be(1)
        expect(subject).to render_template(:creations)
        expect(response).to be_successful
      end
    end
  end
end
