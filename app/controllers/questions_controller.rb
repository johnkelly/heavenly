class QuestionsController < ApplicationController
  def create
    @question = current_person.questions.new(question_params)

    if @question.save
      render json: @question, status: :ok
    else
      render json: { errors: @question.errors }, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params
      .require(:question)
      .permit(:product_id, :question)
  end
end
