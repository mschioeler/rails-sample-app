require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "non-existent user flashes danger and flash does not persist" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: 'i-do-no-exist@not-gonna-happen.wtf', password: '123456'} }
    assert_template 'sessions/new'
    assert !!flash[:danger]
    get root_path
    assert flash.empty?
  end

end
