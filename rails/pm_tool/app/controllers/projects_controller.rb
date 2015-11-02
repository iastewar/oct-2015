class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def new
    @p = Project.new
  end

  def create
    @p = Project.new(project_params)
    if @p.save
      redirect_to(project_path(@p), notice: "Project created!")
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @p.update project_params
      redirect_to(project_path(@p))
    else
      render :edit
    end
  end

  def index
    @projects = Project.all
  end

  def destroy
    @p.destroy
    flash[:notice] = "Project deleted successfully"
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit([:title, :description, :due_date])
  end

  def find_project
    @p = Project.find params[:id]
  end
end
