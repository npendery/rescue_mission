class QuestionsController < ApplicationController

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = session[:user_id]

    if @question.save
      flash[:notice] = "Question Saved"
      redirect_to question_path(@question)
    else
      flash[:alert] = "Question not saved"
      render :new
    end
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      flash[:notice] = "Question Updated"
      redirect_to question_path(@question)
    else
      flash[:alert] = "Question not updated"
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    @question.destroy
    flash[:notice] = "Question Deleted"
    redirect_to questions_path
  end

  private
    def question_params
      params.require(:question).permit(:title, :description)
    end
end
