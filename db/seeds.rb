survey_one = Survey.where(title: 'Survey 1').first_or_create
survey_two = Survey.where(title: 'Survey 2').first_or_create

question_type = Question::QUESTION_TYPE

# questions for survey one
question_one = Question.create({title: 'Q1', question_type: question_type[:single], survey_id: survey_one.id})
question_two = Question.create({title: 'Q2', question_type: question_type[:multiple], survey_id: survey_one.id})
question_three = Question.create({title: 'Q3', question_type: question_type[:text], survey_id: survey_one.id})
question_four = Question.create({title: 'Q4', question_type: question_type[:text], survey_id: survey_one.id})
question_five = Question.create({title: 'Q5', question_type: question_type[:single], survey_id: survey_one.id})
question_six = Question.create({title: 'Q6', question_type: question_type[:text], survey_id: survey_one.id})
question_seven = Question.create({title: 'Q7', question_type: question_type[:single], survey_id: survey_one.id})
question_eight = Question.create({title: 'Q8', question_type: question_type[:text], survey_id: survey_one.id})

# create QuestionChoices for question Q1
QuestionChoice.create({title: 'QuestionChoice-Q1C1', question_id: question_one.id, next_question_id: question_three.id})
QuestionChoice.create({title: 'QuestionChoice-Q1C2', question_id: question_one.id, next_question_id: question_five.id})
QuestionChoice.create({title: 'QuestionChoice-Q1C3', question_id: question_one.id})

# create QuestionChoices for question Q2
QuestionChoice.create({title: 'QuestionChoice-Q2C1', question_id: question_two.id })
QuestionChoice.create({title: 'QuestionChoice-Q2C2', question_id: question_two.id })
QuestionChoice.create({title: 'QuestionChoice-Q2C3', question_id: question_two.id})

# create QuestionChoices for question Q5
QuestionChoice.create({title: 'QuestionChoice-Q5C1', question_id: question_five.id, next_question_id: question_eight.id })
QuestionChoice.create({title: 'QuestionChoice-Q5C2', question_id: question_five.id})
QuestionChoice.create({title: 'QuestionChoice-Q5C3', question_id: question_five.id , next_question_id: question_seven.id})

# create QuestionChoices for question Q7
QuestionChoice.create({title: 'QuestionChoice-Q7C1', question_id: question_seven.id })
QuestionChoice.create({title: 'QuestionChoice-Q7C2', question_id: question_seven.id })
QuestionChoice.create({title: 'QuestionChoice-Q7C3', question_id: question_seven.id })

# create anser for question 1
Answer.create(question_id: question_one.id, response: 'QuestionChoice-Q1C1')
Answer.create(question_id: question_three.id, response: 'answer Q3')
Answer.create(question_id: question_four.id, response: 'answer Q4')
Answer.create(question_id: question_five.id, response: 'QuestionChoice-Q5C3')
Answer.create(question_id: question_seven.id, response: 'QuestionChoice-Q7C2')
Answer.create(question_id: question_eight.id, response: 'answer Q8')
