RSpec.describe Admin::UsersController, type: :controller  do
  let!(:admin){FactoryGirl.create :admin}
  let!(:user){FactoryGirl.create :user}
  let!(:another_user){FactoryGirl.create :user}
  before{sign_in admin}

  describe "GET index" do
    before{get :index}
    it{expect(response).to be_success}
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :index}
    it{expect(assigns(:users)).to match_array([admin, user, another_user])}
  end

  describe "GET new" do
    before{get :new}
    it{expect(response).to be_success}
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :new}
  end

  describe "POST create" do
    context "create with valid attributes" do
      before{post :create, user: FactoryGirl.attributes_for(:user)}
      it{expect(response).to have_http_status 302}
      it{expect(response).to redirect_to action: :index}
    end
    context "create with invalid password" do
      before{post :create, user: FactoryGirl.attributes_for(:invalid_password_user)}
      it{expect(response).to have_http_status 200}
      it{expect(response).to render_template :new}
    end
    context "create with invalid email user" do
      before{post :create, user: FactoryGirl.attributes_for(:invalid_email_user)}
      it{expect(response).to have_http_status 200}
      it{expect(response).to render_template :new}
    end
  end

  describe "PUT update" do
    context "update with valid attributes" do
      before{put :update, id: another_user,
        user: FactoryGirl.attributes_for(:user)}
      it{expect(response).to redirect_to action: :index}
      it{expect(response).to have_http_status 302}
    end
    context "update with invalid password" do
      before{post :create, id: another_user,
        user: FactoryGirl.attributes_for(:invalid_password_user)}
      it{expect(response).to have_http_status 200}
      it{expect(response).to render_template :new}
    end
    context "update with invalid email user" do
      before{post :create, id: another_user,
        user: FactoryGirl.attributes_for(:invalid_email_user)}
      it{expect(response).to render_template :new}
      it{expect(response).to have_http_status 200}
    end
  end

  describe "DELETE destroy" do
    before{delete :destroy, id: user.id}
    it{expect(response).to redirect_to action: :index}
    it{expect(response).to have_http_status 302}
  end
end
