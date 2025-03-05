document.addEventListener("turbo:load", () => {
  const codeBlocks = document.querySelectorAll(".note-body pre code")

  for (const block of codeBlocks) {
    for (const cls of block.classList) {
      if (cls.startsWith("language-")) {
        hljs.highlightBlock(block)
      }
    }
  }
})
