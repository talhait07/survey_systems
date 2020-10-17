class Api::V1::SurveysController < Api::ApiBaseController
  before_action :fetch_survey, only: [:show]

  # GET api/v1/surveys
  def index
    render json: Survey.all, status: :ok
  end

  # GET api/v1/surveys/:id
  def show
    survey = ::SurveySerializer.new(@survey).attributes
    survey[:question] = QuestionService.new(survey: @survey).get_survey_questions
    render json: survey, status: :ok
  end

  private

  def fetch_survey
    @survey = Survey.find(params[:id])
  end
end
