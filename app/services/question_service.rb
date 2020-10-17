class QuestionService
  def initialize(survey:, question: nil, answer_text: nil)
    @survey = survey
    @question = question
    @answer_text = answer_text
  end

  def find_next_question
    next_question_id = QuestionChoice.where(question_id: @question.id, title: @answer_text).last&.next_question_id if @question.question_type == Question::QUESTION_TYPE[:single]
    @survey.questions.where(id: next_question_id).first || @survey.questions.where('id > ?', @question.id).first
  end

  def get_survey_questions
    questions = @survey.questions
    questions.map {|question| ::QuestionAndChoiceSerializer.new(question) }
  end
end