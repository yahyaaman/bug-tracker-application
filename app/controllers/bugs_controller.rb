class BugsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
        @bugs = Bug.all
    end

    def show
        @bug = Bug.find(params[:id])
    end

    def new
        @bug = Bug.new
    end

    def create
        @bug = current_user.bugs.build(params.require(:bug).permit(:title, :description, :deadline, :bug_type, :bug_status, :project_id, :screenshot))
        
        respond_to do |format|
            if @bug.save
                format.html { redirect_to bug_url(@bug), notice: "Bug was successfully created." }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def edit
        @bug = Bug.find(params[:id])
    end

    def update
        respond_to do |format|
            if @bug.update(params.require(:bug).permit(:title, :description, :deadline, :bug_type, :bug_status, :project_id, :developer_id, :screenshot))
                format.html { redirect_to bug_url(@bug), notice: "Bug was successfully updated." }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @bug = Bug.find(params[:id])
        if current_user.id == @bug.user_id
          @bug.destroy
          respond_to do |format|
            format.html { redirect_to bugs_url, notice: "Bug was deleted successfully." }
          end
        else
          respond_to do |format|
            format.html { redirect_to bugs_url, alert: "Access denied. Only bug creator can delete the bug" }
          end
        end
    end
      

    private

    def bug_params
    params.require(:bug).permit(:title, :description, :deadline, :bug_type, :bug_status, :project_id, :screenshot)
    end

end