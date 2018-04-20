class PagesController < ApplicationController
  def index
    @user = current_user
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new
    @page.title = params[:page][:title]
    @page.body = params[:page][:body]
    @page.user = current_user

    authorize @page

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
    @page.title = params[:page][:title]
    @page.body = params[:page][:body]
    @page.user = current_user

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


end
