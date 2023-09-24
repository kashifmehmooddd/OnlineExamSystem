# frozen_string_literal: true

require 'test_helper'

class StudentScoreControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get student_score_index_url
    assert_response :success
  end

  test 'should get show' do
    get student_score_show_url
    assert_response :success
  end
end
