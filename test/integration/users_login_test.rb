require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "non-existent user flashes danger and flash does not persist" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: @user.email, password: 'wrong-password'} }
    assert_template 'sessions/new'
    assert !!flash[:danger]
    post login_path, params: { session: {email: @user.email, password: 'password'} } #correct password
    assert_redirected_to @user
    assert tv_logged_in?
    follow_redirect!
    assert_template 'users/show'
    # get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: "password" }}
    assert_redirected_to @user
    assert tv_logged_in?
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    delete logout_path
    assert_not tv_logged_in?
    assert_redirected_to root_url
    # simulate a user logging out from a second window in same browser
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "logging in with remember_me stores cookie" do
    log_in_as @user, remember_me: '1'
    assert tv_logged_in?
    # 'assigns' is a list of instance variables in the controller
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "logging in without remember_me does not store cookies" do
    assert cookies['remember_token'].nil?
    # Log in to set the cookie (otherwise cookie will be null).
    log_in_as @user, remember_me: '1'
    # Log in again and verify that the cookie is deleted.
    log_in_as @user, remember_me: '0'
    assert tv_logged_in?
    assert_empty cookies['remember_token']
  end
end
