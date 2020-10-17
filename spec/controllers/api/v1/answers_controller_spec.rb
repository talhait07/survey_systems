require 'rails_helper'

RSpec.describe "Api::V1::Answers", type: :request do
  # Initialize the test data
  # create a survey
  let!(:survey) { create(:survey) }
  let!(:survey_id) { survey.id }

  # create two questions for the above survey
  let!(:question_1) { create(:question, survey_id: survey.id, question_type: Question::QUESTION_TYPE[:single]) }
  let(:first_question_id) { question_1.id }

  let!(:question_2) { create(:question, survey_id: survey.id, question_type: Question::QUESTION_TYPE[:multiple]) }
  let(:second_question_id) { question_2.id }

  let!(:question_3) { create(:question, survey_id: survey.id, question_type: Question::QUESTION_TYPE[:text]) }
  let(:third_question_id) { question_3.id }
  # create questions choice

  let!(:first_question_choice_one) { create(:question_choice, question_id: first_question_id, next_question_id: third_question_id) }
  let!(:first_question_choice_two) { create(:question_choice, question_id: first_question_id) }
  let!(:second_question_choices) { create_list(:question_choice, 3, question_id: second_question_id) }

  # create questions answer
  let!(:answer_for_question_1) { create(:answer, question_id: first_question_id, response: first_question_choice_one.title) }

  let!(:answer_for_question_2) { create_list(:answer, 2, question_id: second_question_id, response: second_question_choices.first.title) }

  # Test suite for POST /api/v1/surveys/:survey_id/answers
  describe 'POST /api/v1/surveys/:survey_id/answers' do

    context 'when request attributes are valid and has logic jump' do
      let(:valid_attributes) { { question_id: first_question_id, response: first_question_choice_one.title } }

      before { post "/api/v1/surveys/#{survey_id}/answers", params: valid_attributes }

      it 'should return status code 201' do
        expect(response).to have_http_status(201)
      end

      # jump of question, here skipping question-2
      it 'should return next question-3 as next question' do
        expect(json['id']).to eq(third_question_id)
        expect(json['question_type']).to eq('input_text')
      end
    end

    context 'when request attributes are valid and without logic jump' do
      let(:valid_attributes) { { question_id: first_question_id, response: first_question_choice_two.title } }

      # first_question_choice_two does not have logic jump
      before { post "/api/v1/surveys/#{survey_id}/answers", params: valid_attributes }

      it 'should return status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'should return next question-2 as next question' do
        expect(json['id']).to eq(second_question_id)
        expect(json['question_type']).to eq('multiple_choice')
      end
    end

    context 'when request attributes are valid for last question' do
      let(:valid_attributes) { { question_id: third_question_id, response: "My custom input" } }

      # this should return a message that survey has been completed
      before { post "/api/v1/surveys/#{survey_id}/answers", params: valid_attributes }

      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return survey complete message' do
        expect(json['message']).to eq('The survey has been completed. Thank you!!!')
      end
    end

    context 'when an invalid request without answer params' do
      before { post "/api/v1/surveys/#{survey_id}/answers", params: {question_id: first_question_id} }

      it 'should return status code 422' do
        expect(response).to have_http_status(412)
      end

      it 'should return a failure message' do
        expect(json['error']).to match(/Anwser is missing/)
      end
    end

    context 'when an invalid request without question_id' do
      before { post "/api/v1/surveys/#{survey_id}/answers", params: {response: first_question_choice_one.title} }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a failure message' do
        expect(response.body).to match(/Couldn't find Question without an ID/)
      end
    end

    context 'when an invalid request with invalid question_id' do
      before { post "/api/v1/surveys/#{survey_id}/answers", params: {question_id: 856989, response: first_question_choice_one.title} }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a failure message' do
        expect(response.body).to match(/Couldn't find Question/)
      end
    end

    context 'when an invalid request with invalid survey_id' do
      before { post "/api/v1/surveys/#{54896}/answers", params: {question_id: first_question_id, response: first_question_choice_one.title} }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a failure message' do
        expect(response.body).to match(/Couldn't find Survey/)
      end
    end
  end

  # Test suite for GET /api/v1/surveys/:survey_id/answers
  describe 'GET /api/v1/surveys/:survey_id/answers' do
    before { get "/api/v1/surveys/#{survey_id}/answers" }

    context 'when survey exists' do
      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'should return all questions of this survey' do
        expect(json['questions'].size).to eq(3)
      end

      it 'should return answer for every question' do
        expect(json['questions'][0]['answers'].size).to eq(1)
        expect(json['questions'][1]['answers'].size).to eq(2)
        expect(json['questions'][2]['answers'].size).to eq(0)
      end
    end
  end
end
