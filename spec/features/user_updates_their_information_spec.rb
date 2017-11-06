require "rails_helper"

describe "user visits their update page" do
  it "they update their password and username" do
    user = User.create(first_name: "First",
                        last_name: "Last",
                        username: "Username",
                        password: "password")

    old_username = user.username
    new_username = "newUsername"
    visit user_path(user)

    click_link "Update Your Information"
    fill_in "password", with: "newPassword"
    fill_in "username", with: new_username
    click "Submit"

    expect(current_path).to be user_path(user)
    expect(page).to have_content(new_username)
    expect(page).to_not have_content(old_username)
  end
end
