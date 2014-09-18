shared_examples "require unauthenticated user" do
  before do
    sets_current_user
    action
  end

  it "redirects to projects index page" do
    expect(response).to redirect_to projects_path
  end

  it "sets an error message" do
    expect(flash[:danger]).to be_present
  end
end

shared_examples "require authenticated user" do
  before do
    clear_current_user
    action
  end

  it "redirects to root path" do
    expect(response).to redirect_to root_path
  end

  it "sets an error message" do
    expect(flash[:danger]).to be_present
  end
end

shared_examples "require owner" do
  before do
    @alice = Fabricate(:user)
    @bob = Fabricate(:user)
    sets_current_user(@alice)
    action
  end

  it "redirects to the user show page" do
    expect(response).to redirect_to user_path(@alice)
  end

  it "sets an error message" do
    expect(flash[:danger]).to be_present
  end
end

shared_examples "require project to belong to current user" do
  let(:alice) { Fabricate(:user) }

  before do
    sets_current_user(alice)
    @project = Fabricate(:project)
    action
  end

  it "sets an error message" do
    expect(flash[:danger]).to be_present
  end

  it "redirects to user show page" do
    expect(response).to redirect_to alice
  end
end