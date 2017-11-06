require "rails_helper"

describe "user visits their update page" do
  it "they update their password and username" do
    user = User.create(first_name: "First",
                        last_name: "Last",
                        username: "Username",
                        password: "password")

    old_username = user.username
    new_username = "new_username"

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit user_path(user)

    click_link "Update Your Information"
    fill_in "user[password]", with: "newPassword"
    fill_in "user[username]", with: new_username
    click_button "Update User"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content(new_username)
    expect(page).to_not have_content(old_username)
  end
end
