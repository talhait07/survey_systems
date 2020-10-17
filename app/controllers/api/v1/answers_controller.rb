class Api::V1::AnswersController < Api::ApiBaseController
  before_action :set_survey
  before_action :set_question, only: [:create]

  # GET api/v1/surveys/:survey_id/answers
  def index
    render json: @survey, include: [questions: :answers], status: :ok
  end

  def create
    return render status: 412, json: {error: 'Anwser is missing'} unless answer_params[:response]

    next_question = QuestionService.new(survey: @survey, question: @question, answer_text: answer_params[:response]&.strip).find_next_question

    @question.answers.create!(answer_params)

    if next_question.nil?
      render json: {message: 'The survey has been completed. Thank you!!!'}, status: :ok
    else
      # serialize question with available choices
      next_question_details = ::QuestionAndChoiceSerializer.new(next_question).serializable_hash

      render json: next_question_details, status: :created
    end
  end


  private

  def answer_params
    params.permit(:question_id, :response)
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
