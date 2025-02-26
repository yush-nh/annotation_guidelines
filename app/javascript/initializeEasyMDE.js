const events = ['turbo:load', 'turbo:render']

for (const event of events) {
  document.addEventListener(event, () => {
    const textArea = document.querySelector(".note-textarea")

    if (textArea && !textArea.dataset.easyMDEInitialized) {
      // Set flag to avoid double initialization.
      textArea.dataset.easyMDEInitialized = "true"

      new EasyMDE({
        element: textArea,
        spellChecker: false,
        status: false,
        sideBySideFullscreen: false,
        theme: "", // Disable theme.
        minHeight: "500px",
        toolbar: [
          "bold",
          "italic",
          "heading",
          "|",
          "quote",
          "code",
          "unordered-list",
          "ordered-list",
          "|",
          "preview",
          "side-by-side",
          "fullscreen"
        ]
      })
    }
  })
}

