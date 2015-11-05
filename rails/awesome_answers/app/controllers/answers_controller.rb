class AnswersController < ApplicationController

  def create
    answer_params = params.require(:answer).permit(:body)
    @q = Question.find params[:question_id]
    @answer = Answer.new answer_params
    @answer.question = @q

    if @answer.save
      redirect_to question_path(@q), notice: "Answer created succussfully!"
    else
      render "questions/show"
    end
  end

  def destroy
    answer = Answer.find_by_id params[:id]
    if answer
      answer.destroy
      redirect_to question_path(answer.question), notice: "Answer deleted"
    else
      redirect_to question_path(params[:question_id]), notice: "Answer already deleted"
    end

  end
end
