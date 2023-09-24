# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }
  root to: 'exams#index'
  resources :exams do
    member do
      patch :update_status
      patch :restart_exam
    end

    collection do
      get :pendings
      get :creations
      get :finished
    end

    resources :questions

    resources :user_answers, only: %i[new create]
  end

  resources :student_score, only: %i[index show]
  resources :subjects, only: %i[index new create]
end
