require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid form submission does not create user' do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post users_path, params: { user: {name: "",
                                        email: "user@invalid",
                                        password: "foo",
                                        password_confirmation: "bar" } }
    end
    assert_select '#error_explanation'
    assert_template 'users/new'
  end

  test 'valid form submission does create user' do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {name: "Example User",
                                        email: "user@valid.com",
                                        password: "password",
                                        password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_select '.alert-success'
    assert_not flash.empty?
  end

end
