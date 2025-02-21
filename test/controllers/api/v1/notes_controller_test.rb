require "test_helper"

class Api::V1::NotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    user = users(:one)
    user.create_access_token!
    @access_token = user.access_token.token
    @note = notes(:one)
  end

  test "POST_should_create_note" do
    assert_difference("Note.count", 1) do
      post "/api/v1/notes", params: { title: "test", body: "test" },
                            as: :json,
                            headers: { "Authorization" => "Bearer #{@access_token}" }
    end
  end

  test "GET_should_show_note" do
    get "/api/v1/notes/#{@note.uuid}"

    json_response = JSON.parse(response.body)
    assert_equal @note.title, json_response["title"]
    assert_equal @note.body, json_response["body"]
  end

  test "PUT_should_update_note" do
    put "/api/v1/notes/#{@note.uuid}", params: { title: "test", body: "updated" },
                                       as: :json,
                                       headers: { "Authorization" => "Bearer #{@access_token}" }

    @note.reload
    assert_equal "updated", @note.body
  end

  test "DELETE_should_delete_note" do
    assert_difference("Note.count", -1) do
      delete "/api/v1/notes/#{@note.uuid}", headers: { "Authorization" => "Bearer #{@access_token}" }
    end
  end

  # Exceptions Test

  test "should_return_422_when_record_invalid" do
    post "/api/v1/notes", params: { title: "", body: "" },
                          as: :json,
                          headers: { "Authorization" => "Bearer #{@access_token}" }

    assert_response 422
  end

  test "should_return_404_when_record_not_found" do
     get "/api/v1/notes/123"

     assert_response 404
  end
end
