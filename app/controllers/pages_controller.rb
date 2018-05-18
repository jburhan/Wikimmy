class PagesController < ApplicationController
  def index
    @user = current_user
    @pages = policy_scope(Page)
  end

  def show
    @page = Page.find(params[:id])
    unless (@page.private == false) || current_user.premium? || current_user.admin?
      flash[:alert] = "You must be a premium user to view private wikis."
      if current_user
        redirect_to new_charge_path
      else
        redirect_to new_user_registration_path
      end
    end
  end

  def new
    @page = Page.new
  end

  def create
    @page = current_user.pages.build(page_params)
    if @page.save
      flash[:notice] = "Wiki was saved."
      redirect_to @page
    else
      flash.now[:alert] = "There was an error saving your wiki, please try again."
      render :new
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    authorize @page

    if @page.save
      flash[:notice] = "Wiki was updated."
      redirect_to @page
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @page = Page.find(params[:id])
    authorize @page

    if @page.destroy
      flash[:notice] = "\"#{@page.title}\" was deleted successfully."
      redirect_to @page
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :body, :private)
  end


end
