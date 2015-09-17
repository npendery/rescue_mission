class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /Answers
  # GET /Answers.json
  def index
    @answers = Answer.all.order(created_at: :desc)
  end

  # GET /Answers/1
  # GET /Answers/1.json
  def show
    @answer = Answer.find(params[:id])
  end

  # GET /Answers/new
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  # GET /Answers/1/edit
  def edit
  end

  # POST /Answers
  # POST /Answers.json
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @answer.user_id = session[:user_id]

    if @answer.save
      flash[:notice] = "Answer Saved"
      redirect_to question_path(@question)
    else
      flash[:alert] = "Answer not saved"
      render :new
    end
  end

  # PATCH/PUT /Answers/1
  # PATCH/PUT /Answers/1.json
  def update

    @answer = Answer.find(params[:id])
    @question = @answer.question

    @answer.update(answer_params)

    flash[:notice] = "Answer Updated"
    redirect_to question_path(@question)
  end

  # DELETE /Answers/1
  # DELETE /Answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:description, :best_answer)
    end
end
