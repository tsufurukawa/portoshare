require 'rails_helper'

describe PasswordResetsController do
  describe "GET new" do
    it_behaves_like "require authenticated user" do
      let(:action) { get :new, user_id: 1 }
    end

    it_behaves_like "require owner" do
      let(:action) { get :new, user_id: @bob.id }
    end

    it "sets @user variable" do
      alice = Fabricate(:user)
      sets_current_user(alice)
      get :new, user_id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end

  describe "POST create" do
    it_behaves_like "require authenticated user" do
      let(:action) { post :create, user_id: 1 }
    end

    it_behaves_like "require owner" do
      let(:action) { post :create, user_id: @bob.id }
    end

    context "old password cannot be found" do
      let(:alice) { Fabricate(:user, password: "password") }

      before do
        sets_current_user(alice)
        post :create, user_id: alice.id, old_password: "wrong password"
      end

      it "renders new template" do
        expect(response).to render_template :new
      end

      it "sets a flash error message" do
        expect(flash[:danger]).to eq("The password you entered is incorrect. Please try again.")
      end
    end

    context "new password is invalid" do
      let(:alice) { Fabricate(:user, password: "password") }

      before do
        sets_current_user(alice)
        post :create, user_id: alice.id, old_password: "password", 
          new_password: "123", new_password_confirmation: "123"
      end

      it "renders new template" do
        expect(response).to render_template :new
      end

      it "does not update the password" do
        expect(alice.reload.authenticate("123")).to be_falsy
      end
    end

    context "password confirmation does not match" do
      let(:alice) { Fabricate(:user, password: "password") }

      before do
        sets_current_user(alice)
        post :create, user_id: alice.id, old_password: "password",
          new_password: "new password 1", new_password_confirmation: "new password 2"
      end

      it "sets a flash error message" do
        expect(flash[:danger]).to eq("The new passwords did not match. Please try again.")
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "does not update the password" do
        expect(alice.reload.authenticate("new password 1")).to be_falsy
      end
    end

    context "password reset is successful" do
      let(:alice) { Fabricate(:user, password: "password") }

      before do
        sets_current_user(alice)
        post :create, user_id: alice.id, old_password: "password",
          new_password: "new password", new_password_confirmation: "new password"
      end

      it "resets the password" do
        expect(alice.reload.authenticate("new password")).to be_truthy
        expect(alice.reload.authenticate("password")).to be_falsy
      end

      it "redirects to user show path" do
        expect(response).to redirect_to alice
      end
    end
  end
end