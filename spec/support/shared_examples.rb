shared_examples "require unauthenticated user" do
  before do
    sets_current_user
    action
  end

  #TODO: change projects_path
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