const events = ['turbo:load', 'turbo:render']

for (const event of events) {
  document.addEventListener(event, () => {
    const textArea = document.querySelector(".note-textarea")

    if (textArea && !textArea.dataset.easyMDEInitialized) {
      // Set flag to avoid double initialization.
      textArea.dataset.easyMDEInitialized = "true"

      const easyMDE = new EasyMDE({
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
        ],
        previewRender: (plainText, preview) => {
          preview.innerHTML = easyMDE.markdown(plainText)
          const codeBlocks = document.querySelectorAll("pre code")

          // Enable syntax highlighting only when language is specified in the code block.
          for (const block of codeBlocks) {
            if (block.classList.length === 0) continue

            hljs.highlightBlock(block)
          }

          return preview.innerHTML
        }
      })
    }
  })
}

