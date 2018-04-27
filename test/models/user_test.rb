require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "initial user is valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name must not be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email must not be too long" do
    @user.email = "a"*256 # max db string length=255
    assert_not @user.valid?
  end

end
