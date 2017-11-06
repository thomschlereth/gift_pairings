require "rails_helper"

describe "user visits show" do
  it "they see who they give to" do
    reciever = User.create(first_name: "Reciever",
                            last_name: "Last",
                            username: "Receiver",
                            password: "password")

    user = User.create(first_name: "First",
                        last_name: "Last",
                        username: "Username",
                        reciever: reciever,
                        password: "password")

    visit user_path(user)

    expect(page).to have_content("Welcome #{user.first_name} #{user.last_name}")
    expect(page).to have_content("You will be giving to #{reciever.first_name} #{reciever.last_name}")
  end
end
