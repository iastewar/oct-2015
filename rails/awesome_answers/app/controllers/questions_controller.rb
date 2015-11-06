class QuestionsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize, only: [:edit, :update, :destroy]

  def new
    authenticate_user

    @q = Question.new
  end

  def create
    authenticate_user
    # mass assignment
    # Question.create(params[:question])
    # Question.create({title: params[:question][:title], body: params[:question][:body]})
    question_params = params.require(:question).permit([:title, :body])
    @q = Question.new(question_params)
    @q.user = current_user
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


    redirect_to root_path, alert: "Access denied." unless can? :edit, @q

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

  private

  def authorize
    #redirect_to root_path, notice: "Access denied!" unless can? :manage, @q
  end
end
