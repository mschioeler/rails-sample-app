require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "non-existent user flashes danger and flash does not persist" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: 'i-do-no-exist@not-gonna-happen.wtf', password: '123456'} }
    assert_template 'sessions/new'
    assert !!flash[:danger]
    get root_path
    assert flash.empty?
  end

  test "header is session-dynamic" do
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
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

end
