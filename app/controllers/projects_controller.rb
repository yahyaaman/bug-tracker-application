class ProjectsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
        if current_user.manager?
            @projects = current_user.projects
        else
            redirect_to root_url, alert: "Access denied. You are not authorized to view this page."
        end
    end

    def show
        @project = Project.find(params[:id])
        unless current_user.id == @project.user_id || current_user.user_projects.exists?(project_id: @project.id)
          redirect_to root_url, alert: "Access denied. You are not authorized to view this project."
        end
      end
      

    def new
        @project = Project.new
    end

    def create
        @project = current_user.projects.build(params.require(:project).permit(:title, user_ids: []))
        
        respond_to do |format|
            if @project.save
            format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
            else
            format.html { render :new, status: :unprocessable_entity }
            end
        end
    end
      
    def edit
        @project = Project.find(params[:id])
        if current_user.id != @project.user_id
            redirect_to root_url, alert: "Access denied. You are not authorized to view this project."
        end
    end

    def update
        @project = Project.find(params[:id])
        respond_to do |format|
            if current_user.id == @project.user_id && @project.update(params.require(:project).permit(:title, user_ids: []))
            format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
            elsif current_user.id != @project.user_id
                format.html { redirect_to project_url(@project), notice: "Only Project owner can edit the project." }
            else
            format.html { render :edit, status: :unprocessable_entity }
            end
        end
    end
      

    def destroy
        @project = Project.find(params[:id])
        respond_to do |format|
            @project.destroy
            format.html { redirect_to projects_url, notice: "Project was deleted successfully." }
        end
    end

    private

    def project_params
    params.require(:project).permit(:title, user_ids: [])
    end

end
  