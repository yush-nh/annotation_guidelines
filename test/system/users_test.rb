require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    Note.create!(title: "new note", updated_at: 1.day.ago, user: @user)
    Note.create!(title: "old note", updated_at: 2.day.ago, user: @user)
  end

  test "title should sortable by ascending" do
    visit user_path(@user.email, sort_column: "title", sort_direction: "asc")

    titles = all("td.note-title").map(&:text)
    expected_order = Note.order("title asc").pluck(:title)

    assert_equal expected_order, titles
  end

  test "title should sortable by descending" do
    visit user_path(@user.email, sort_column: "title", sort_direction: "desc")

    titles = all("td.note-title").map(&:text)
    expected_order = Note.order("title desc").pluck(:title)

    assert_equal expected_order, titles
  end

  test "author should sortable by ascending" do
    visit user_path(@user.email, sort_column: "author", sort_direction: "asc")

    authors = all("td.note-author").map(&:text)
    expected_order = Note.includes(:user).order("users.email asc").pluck(:email)

    assert_equal expected_order, authors
  end

  test "author should sortable by descending" do
    visit user_path(@user.email, sort_column: "author", sort_direction: "desc")

    authors = all("td.note-author").map(&:text)
    expected_order = Note.includes(:user).order("users.email desc").pluck(:email)

    assert_equal expected_order, authors
  end

  test "updated_at should sortable by ascending" do
    visit user_path(@user.email, sort_column: "updated_at", sort_direction: "asc")

    updated_at_array = all("td.note-updated-at").map(&:text)
    expected_order = Note.order("updated_at asc").pluck(:updated_at).map { it.strftime("%Y-%m-%d %H:%M:%S %Z") }

    assert_equal expected_order, updated_at_array
  end

  test "updated_at should sortable by descending" do
    visit user_path(@user.email, sort_column: "updated_at", sort_direction: "desc")

    updated_at_array = all("td.note-updated-at").map(&:text)
    expected_order = Note.order("updated_at desc").pluck(:updated_at).map { it.strftime("%Y-%m-%d %H:%M:%S %Z") }

    assert_equal expected_order, updated_at_array
  end
end
