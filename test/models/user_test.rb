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

  test "valid emails should be accepted" do
    valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org
        first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "invalid emails should be rejected" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. 
        foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

end