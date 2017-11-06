require 'rails_helper'

describe 'User visits homepage' do
  it 'User clicks login' do
    event = Occasion.create(title: "Test")
    user = User.create(first_name: "First",
                        last_name: "Last",
                        username: "Username",
                        password: "notpassword")
    event.occasions_users.create(user: user)

    visit '/'

    click_link 'Login'

    fill_in 'username', with: user.username
    fill_in 'password', with: 'notpassword'

    click_button 'Login'

    expect(current_path).to eq(user_path(user))

  end

  it "User with password of password is redirect to change password" do
    event = Occasion.create(title: "Test")
    user = User.create(first_name: "First",
                        last_name: "Last",
                        username: "Username",
                        password: "password")
    event.occasions_users.create(user: user)

    visit '/'

    click_link 'Login'
    fill_in 'username', with: user.username
    fill_in 'password', with: 'password'

    click_button 'Login'

    expect(current_path).to eq(edit_user_path(user))
    expect(page).to have_content("Since this is your first visit, please update your password before continuing.")

    fill_in 'password', with: "newpassword"
    click_button "Update User"

    expect(current_path).to eq user_path(user)
  end
end
