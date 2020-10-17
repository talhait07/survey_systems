
require 'rails_helper'

RSpec.describe QuestionService, type: :class do
  let!(:survey) { create(:survey) }
  let!(:survey_id) { survey.id }

  let!(:question_1) { create(:question, survey_id: survey.id, question_type: Question::QUESTION_TYPE[:single]) }
  let(:first_question_id) { question_1.id }

  let!(:question_2) { create(:question, survey_id: survey.id, question_type: Question::QUESTION_TYPE[:multiple]) }
  let(:second_question_id) { question_2.id }

  let!(:question_3) { create(:question, survey_id: survey.id, question_type: Question::QUESTION_TYPE[:text]) }
  let(:third_question_id) { question_3.id }

  let!(:question_4) { create(:question, survey_id: survey.id, question_type: Question::QUESTION_TYPE[:text]) }
  let(:fourth_question_id) { question_4.id }

  let!(:question_choice_one) { create(:question_choice, question_id: first_question_id, next_question_id: third_question_id) }

  let(:response_from_question_service_1) { QuestionService.new(survey: survey, question: question_1, answer_text: question_choice_one.title).find_next_question }
  let(:response_from_question_service_2) { QuestionService.new(survey: survey, question: question_3, answer_text: question_choice_one.title).find_next_question }
  let(:response_from_question_service_3) { QuestionService.new(survey: survey).get_survey_questions }

  describe 'find the next question' do
    it 'should return the next question as question_3' do
      expect(response_from_question_service_1.id).to eq question_choice_one.next_question_id
    end

    it 'should return the following question' do
      expect(response_from_question_service_2.id).to eq question_4.id
    end
  end

  describe "get the questions with choices" do
    it 'should return the list of question with choices' do
      expect(response_from_question_service_3).not_to be_empty
    end
  end
end