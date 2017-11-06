require 'rails_helper'

describe 'User visits homepage' do
  it 'User clicks login' do
    user = User.create(first_name: "First",
                        last_name: "Last",
                        username: "Username",
                        password: "password")

    visit '/'

    click_link 'Login'

    fill_in 'username', with: user.username
    fill_in 'password', with: 'password'

    click_button 'Login'

    expect(current_path).to eq(user_path(user))

  end
end
