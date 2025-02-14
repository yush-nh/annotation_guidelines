class AnnotationGuidelinesController < ApplicationController
  def index
    @annotation_guidelines = AnnotationGuideline.includes(:user).order(updated_at: :desc)
  end
end
