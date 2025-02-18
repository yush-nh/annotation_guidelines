require "test_helper"

class NoteTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "valid note should be saved" do
    assert_difference "Note.count", 1 do
      Note.create(
        title: "Note1",
        body: "# Note 1",
        user_id: @user.id
      )
    end
  end

  test "without title should not be saved" do
    note = Note.new(
      title: nil,
      body: "# Note without title",
      user_id: @user.id
    )

    assert note.invalid?
  end

  test "title exceeding 255 chararcters should not be saved" do
    long_title = "a" * 256
    note = Note.new(
      title: long_title,
      body: "# Note with a long title",
      user_id: @user.id
    )

    assert note.invalid?
  end
end
