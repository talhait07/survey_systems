require 'rails_helper'

RSpec.describe "Api::V1::Surveys", type: :request do
  # initialize test data
  let!(:surveys) { create_list(:survey, 3) }
  let(:survey_id) { surveys.first.id }
  let!(:questions) { create_list(:question, 2, survey_id: surveys.first.id, question_type: 'input_text') }
  let(:first_question_id) { questions.first.id }

  # Test suite for GET api/v1/surveys
  describe 'GET api/v1/surveys' do
    # make HTTP get request before each example
    before { get '/api/v1/surveys' }

    it 'should return surveys' do
      # json => processed response of the api
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
      expect(json.first['id']).to eq(surveys.first.id)
    end

    it 'should return the questions if exists' do
      expect(json.first['questions']).not_to be_empty
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET api/v1/surveys/:id
  describe 'GET api/v1/surveys/:id' do
    before { get "/api/v1/surveys/#{survey_id}" }

    context 'when the record exists' do
      it 'should return the survey' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(survey_id)
      end

      it 'should return the first question of survey' do
        expect(json['question'].first['id']).to eq(first_question_id)
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'if the record does not exist' do
      let(:survey_id) { 100 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return not found message' do
        expect(response.body).to match(/Couldn't find Survey/)
      end
    end
  end
end
