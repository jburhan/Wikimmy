require 'rails_helper'
include RandomData

RSpec.describe PagesController, type: :controller do
  let(:user) { create(:user) }
  let(:page) { create(:page) }

  before do
      sign_in(user)
    end

  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: page.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
        get :show, id: page.id
        expect(response).to render_template :show
      end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
        get :new, id: page.id
        expect(response).to render_template :new
    end

    it "instantiates @page" do
      get :new, id: page.id
      expect(assigns(:page)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of Wiki by 1" do
      expect{ page }.to change(Page, :count).by(1)
    end

    it "assigns the new wiki to @page" do
      post :create, id: page.id, page: {title: "New Wiki Title", body: "New Wiki Body"}
      expect(assigns(:page)).to eq Page.last
    end

    it "redirects to the new post" do
      post :create, id: page.id, page: {title: "New Wiki Title", body: "New Wiki Body"}
      expect(response).to redirect_to [Page.last]
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: page.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
        get :edit, id: page.id
        expect(response).to render_template :edit
    end

    it "assigns wiki to be updated to @age" do
      get :edit, id: page.id
      post_instance = assigns(:page)

      expect(post_instance.id).to eq page.id
      expect(post_instance.title).to eq page.title
      expect(post_instance.body).to eq page.body
    end
  end

  describe "PUT update" do
    it "updates wiki with expected attributes" do
      new_title = "New Wiki Title"
      new_body = "New Wiki Body"

      put :update, id: page.id, page: {title: new_title, body: new_body}

      updated_page = assigns(:page)
      expect(updated_page.id).to eq page.id
      expect(updated_page.title).to eq new_title
      expect(updated_page.body).to eq new_body
    end

    it "redirects to the updated wiki" do
      new_title = "New Wiki Title"
      new_body = "New Wiki Body"

      put :update, id: page.id, page: {title: new_title, body: new_body}

      expect(response).to redirect_to [page]
    end
  end

  describe "DELETE destroy" do
    it "deletes the wiki" do
      delete :destroy, id: page.id
      count = Page.where({id: page.id}).size
      expect(count).to eq 0
    end

    it "redirects to page index" do
      delete :destroy, id: page.id
      expect(response).to redirect_to(page)
    end
  end

end
