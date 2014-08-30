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