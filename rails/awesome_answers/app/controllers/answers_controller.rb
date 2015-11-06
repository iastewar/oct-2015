class AnswersController < ApplicationController
  before_action :authenticate_user

  def create
    answer_params = params.require(:answer).permit(:body)
    @q = Question.find params[:question_id]
    @answer = current_user.answers.new answer_params
    @answer.question = @q

    if @answer.save
      redirect_to question_path(@q), notice: "Answer created succussfully!"
    else
      render "questions/show"
    end
  end

  def destroy
    answer = Answer.find_by_id params[:id]
    redirect_to root_path, alert: "Access denied!" and return unless can? :destroy, answer
    if answer
      answer.destroy
      redirect_to question_path(answer.question), notice: "Answer deleted"
    else
      redirect_to question_path(params[:question_id]), notice: "Answer already deleted"
    end

  end

end
