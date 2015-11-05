class SnippetsController < ApplicationController
  before_action :find_snippet, only: [:show, :edit, :update, :destroy]

  def new
    @s = Snippet.new
  end

  def create
    snippet_params = params.require(:snippet).permit([:kind, :title, :work])
    @s = Snippet.new snippet_params
    if @s.save
      redirect_to snippet_path(@s)
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @s.update snippet_params
      redirect_to(snippet_path(@s))
    else
      render :edit
    end
  end

  def index
    #@snippets = Snippet.all
    @snippet_languages = Array.new
    @snippet_languages[0] = ["Ruby", Snippet.where(kind: "Ruby")]
    @snippet_languages[1] = ["HTML", Snippet.where(kind: "HTML")]
    @snippet_languages[2] = ["CSS", Snippet.where(kind: "CSS")]
    @snippet_languages[3] = ["JavaScript", Snippet.where(kind: "JavaScript")]

  end

  def destroy
    @s.destroy
    flash[:notice] = "Code snippet deleted successfully"
    redirect_to snippets_path
  end

  def indexs
    @language = params[:language]
    @snippets = Snippet.where(kind: @language)
  end

  private

  def snippet_params
    params.require(:snippet).permit([:kind, :title, :work])
  end

  def find_snippet
    @s = Snippet.find(params[:id])
  end
end
