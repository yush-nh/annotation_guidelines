class AnnotationGuidelinesController < ApplicationController
  def index
    @annotation_guidelines = AnnotationGuideline.includes(:user)
                                                .order(updated_at: :desc)
                                                .page(params[:page])
  end

  def show
    @annotation_guideline = AnnotationGuideline.find(params[:id])
  end

  def new
    @annotation_guideline = current_user.annotation_guidelines.new()
  end

  def create
    @annotation_guideline = current_user.annotation_guidelines.new(annotation_guideline_params)

    if @annotation_guideline.save
      redirect_to annotation_guidelines_path, notice: "Annotation Guideline was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @annotation_guideline = current_user.annotation_guidelines.find(params[:id])
  end

  def update
    @annotation_guideline = current_user.annotation_guidelines.find(params[:id])

    if @annotation_guideline.update(annotation_guideline_params)
      redirect_to annotation_guideline_path(@annotation_guideline), notice: "Annotation Guideline was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def annotation_guideline_params
    params.require(:annotation_guideline).permit(:title, :body)
  end
end
