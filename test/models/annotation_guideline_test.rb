require "test_helper"

class AnnotationGuidelineTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "valid annotation guideline should be saved" do
    assert_difference "AnnotationGuideline.count", 1 do
      AnnotationGuideline.create(
        title: "Guideline1",
        body: "# Guideline 1",
        user_id: @user.id
      )
    end
  end

  test "without title should not be saved" do
    annotation_guideline = AnnotationGuideline.new(
      title: nil,
      body: "# Guideline without title",
      user_id: @user.id
    )

    assert annotation_guideline.invalid?
  end

  test "title exceeding 255 chararcters should not be saved" do
    long_title = "a" * 256
    annotation_guideline = AnnotationGuideline.new(
      title: long_title,
      body: "# Guideline with a long title",
      user_id: @user.id
    )

    assert annotation_guideline.invalid?
  end
end
