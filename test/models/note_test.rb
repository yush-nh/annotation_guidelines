require "test_helper"

class NoteTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should save when title and body present" do
    assert_difference "Note.count", 1 do
      Note.create(
        title: "Note1",
        body: "# Note 1",
        user_id: @user.id
      )
    end
  end

  test "should save when title present, body empty" do
    assert_difference "Note.count", 1 do
      Note.create(
        title: "Note1",
        body: "",
        user_id: @user.id
      )
    end
  end

  test "should save when title empty, body present" do
    assert_difference "Note.count", 1 do
      Note.create(
        title: "",
        body: "# Note 1",
        user_id: @user.id
      )
    end
  end

  test "should not save when title and body both empty" do
    assert_difference "Note.count", 0 do
      Note.create(
        title: "",
        body: "",
        user_id: @user.id
      )
    end
  end

  test "should set default title when title empty" do
    note = Note.create(
            title: "",
            body: "# Note 1",
            user_id: @user.id
          )

    assert_equal "no title", note.title
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
