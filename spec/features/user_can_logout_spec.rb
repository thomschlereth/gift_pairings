require 'rails_helper'

describe 'User visits homepage as logged in user' do
  it 'User clicks logout' do
    event = Occasion.create(title: "Test")
    user = User.create(first_name: "First",
                        last_name: "Last",
                        username: "Username",
                        password: "notpassword",
                        first_time_toggle: false)
    event.occasions_users.create(user: user)

    visit '/'

    click_link 'Login'
    fill_in 'username', with: user.username
    fill_in 'password', with: 'notpassword'

    click_button 'Login'

    expect(page).to have_content("Logout")
    expect(page).to have_content("Update Your Information")

    expect(page).to_not have_content("Login")

    click_link 'Logout'

    expect(current_path).to eq("/")

    expect(page).to have_content("Login")

    expect(page).to_not have_content("Logout")
    expect(page).to_not have_content("Update Your Information")
  end

end
