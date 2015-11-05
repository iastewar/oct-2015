class QuestionsController < ApplicationController

  def new
    authenticate_user

    @q = Question.new
  end

  def create
    # mass assignment
    # Question.create(params[:question])
    # Question.create({title: params[:question][:title], body: params[:question][:body]})
    question_params = params.require(:question).permit([:title, :body])
    @q = Question.new(question_params)
    if @q.save
      #render text: "Saved correctly"
      #redirect_to(question_path({id: @q.id}))
      # can be shortened to
      redirect_to(question_path(@q))
    else
      # render text: "Didn't save correctly: #{q.errors.full_messages.join(", ")}"
      render :new
    end
    #render text: "Inside Questions Create #{params[:question]}"

  end

  def show
    @q = Question.find(params[:id])
    # need a form on the show page to create an answer for the question
    @answer = Answer.new
    #render text: params
  end

  def edit
    @q = Question.find(params[:id])
  end

  def update
    @q = Question.find(params[:id])
    question_params = params.require(:question).permit([:title, :body])
    if @q.update question_params
      redirect_to(question_path(@q))
    else
      render :edit
    end
  end

  def index
    @questions = Question.all
  end

  def destroy
    @q = Question.find(params[:id])
    @q.destroy

    redirect_to questions_path
  end
end
