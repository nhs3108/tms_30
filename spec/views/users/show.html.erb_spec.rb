RSpec.describe User, type: :view do
  feature "show user" do
    let!(:user) {FactoryGirl.create :user}
    let!(:user1) {FactoryGirl.create :user}
    let!(:admin) {FactoryGirl.create :admin}

    before do
      visit "/login"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Done"
    end

    scenario "User want to show profile" do
      click_link user.name
      expect(page).to have_content user.name
      expect(page).to have_content user.email
      expect(page).to have_content "User activities"
      expect(page).to have_link "Settings"
      expect(page).to have_link "Logout"
    end

    scenario "Edit profile" do
      click_link "Settings"
      fill_in "Name", with: user.name
      fill_in "Password", with: "framgiaVN"
      fill_in "Confirmation", with: "framgiaVN"
      click_button "Submit"
    end

    scenario "User log out" do
      click_link "Logout"
      expect(page).to have_link "Sign in"
    end
  end
end
