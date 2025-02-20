require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user should be saved" do
    assert_difference "User.count", 1 do
      User.create(email: "valid@example.com", password: "password", confirmed_at: Time.now)
    end
  end

  test "invalid email user should not saved" do
    assert_no_difference "User.count" do
      User.create(email: "invalid_email", password: "password", confirmed_at: Time.now)
    end
  end

  test "invalid password user should not saved" do
    assert_no_difference "User.count" do
      User.create(email: "valid2@example.com", password: "short", confirmed_at: Time.now)
    end
  end
end
