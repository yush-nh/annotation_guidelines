document.addEventListener("DOMContentLoaded", function () {
  const textArea = document.getElementById("annotation_guideline_textarea")

  if (textArea) {
    new EasyMDE({
      element: textArea,
      spellChecker: false,
      toolbar: ["bold", "italic", "heading", "|", "quote", "code", "unordered-list", "ordered-list", "|", "preview", "side-by-side", "fullscreen"]
    })
  }
})

