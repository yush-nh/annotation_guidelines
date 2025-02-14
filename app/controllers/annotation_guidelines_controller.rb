class AnnotationGuidelinesController < ApplicationController
  def index
    @annotation_guidelines = AnnotationGuideline.includes(:user)
                                                .order(updated_at: :desc)
                                                .page(params[:page])
  end
end
