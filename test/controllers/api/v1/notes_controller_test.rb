require "test_helper"

class Api::V1::NotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "POST_should_create_note" do
    assert_difference("Note.count", 1) do
      post "/api/v1/notes", params: { title: "test", body: "test" }, as: :json
    end
  end

  # Exceptions Test

  test "should_return_422_when_record_invalid" do
    post "/api/v1/notes", params: { title: "", body: "" }, as: :json

    assert_response 422
  end
end
