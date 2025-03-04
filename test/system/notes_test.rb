require "application_system_test_case"

class NotesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @note1 = Note.create!(title: "new-note", body: "**Hello** _world_", updated_at: 1.day.ago, user_id: @user1.id)
    Note.create!(title: "old-note", updated_at: 2.day.ago, user_id: @user2.id)

    sign_in(@user1)
  end

  test "note should creatable" do
    visit notes_path
    click_on "Add new note"

    fill_in "note_title", with: "New Note Title"
    find(".CodeMirror textarea", visible: false).set("**Hello** _world_")

    click_on "Create"

    assert_text "Note was successfully created."
    assert_text "New Note Title"
    assert_selector "strong", text: "Hello"
    assert_selector "em", text: "world"
  end

  test "note should displayable" do
    visit notes_path
    click_on @note1.title

    assert_text @note1.title
    assert_selector "strong", text: "Hello"
    assert_selector "em", text: "world"
  end

  test "note should updatable" do
    visit note_path(@note1)
    click_on "Edit"

    fill_in "Title", with: "Updated Note Title"
    find(".CodeMirror textarea", visible: false).set("## Updated Content")

    click_on "Update"

    assert_text "Note was successfully updated."
    assert_text "Updated Note Title"
    assert_selector "h2", text: "Updated Content"
  end

  test "note should deletable" do
    visit note_path(@note1)
    accept_confirm do
      click_on "Delete"
    end

    assert_text "Note was successfully deleted."
    refute_text @note1.title
  end

  test "title should sortable by ascending" do
    visit notes_path(sort_column: "title", sort_direction: "asc")

    titles = all("td.note-title").map(&:text)
    expected_order = Note.order("title asc").pluck(:title)

    assert_equal expected_order, titles
  end

  test "title should sortable by descending" do
    visit notes_path(sort_column: "title", sort_direction: "desc")

    titles = all("td.note-title").map(&:text)
    expected_order = Note.order("title desc").pluck(:title)

    assert_equal expected_order, titles
  end

  test "author should sortable by ascending" do
    visit notes_path(sort_column: "author", sort_direction: "asc")

    authors = all("td.note-author").map(&:text)
    expected_order = Note.includes(:user).order("users.email asc").pluck(:email)

    assert_equal expected_order, authors
  end

  test "author should sortable by descending" do
    visit notes_path(sort_column: "author", sort_direction: "desc")

    authors = all("td.note-author").map(&:text)
    expected_order = Note.includes(:user).order("users.email desc").pluck(:email)

    assert_equal expected_order, authors
  end

  test "updated_at should sortable by ascending" do
    visit notes_path(sort_column: "updated_at", sort_direction: "asc")

    updated_at_array = all("td.note-updated-at").map(&:text)
    expected_order = Note.order("updated_at asc").pluck(:updated_at).map { it.strftime("%Y-%m-%d %H:%M:%S %Z") }

    assert_equal expected_order, updated_at_array
  end

  test "updated_at should sortable by descending" do
    visit notes_path(sort_column: "updated_at", sort_direction: "desc")

    updated_at_array = all("td.note-updated-at").map(&:text)
    expected_order = Note.order("updated_at desc").pluck(:updated_at).map { it.strftime("%Y-%m-%d %H:%M:%S %Z") }

    assert_equal expected_order, updated_at_array
  end
end
