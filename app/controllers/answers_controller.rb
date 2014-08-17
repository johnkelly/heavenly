class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @question.replier_id = current_person.id

    if @question.update(answer_params)
      render json: @question, status: :ok
    else
      render json: { errors: @question.errors }, status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params
      .require(:answer)
      .permit(:answer)
  end
end
