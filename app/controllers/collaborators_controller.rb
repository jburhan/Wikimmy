class CollaboratorsController < ApplicationController
  def create
    @page = Page.find(params[:page_id])
    current_collaborators = @page.users
    @user = User.find_by(email: params[:collaborator][:user])

    if User.exists?(@user)
      if current_collaborators.include?(@user) || @user == current_user
        flash[:error] = "User is already a collaborator."
        redirect_to @page
      else
        @collaborator = @page.collaborators.new(page_id: @page.id, user_id: @user.id)

        if @collaborator.save
          flash[:notice] = "Collaborator has been added!"
        else
          flash[:error] = "Error occured, please try again."
        end
        redirect_to @page
      end
    else
      flash[:error] = "We couldn't find the user "
      redirect_to @page
    end
  end

  def destroy
    @page = Page.find(params[:page_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator has been successfully removed. "
      redirect_to @page
    else
      flash.now[:alert] = "There was an error removing this collaborator."
      redirect_to @page
    end
  end
end
