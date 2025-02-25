import ClipboardJS from "clipboard"

document.addEventListener("turbo:load", () => {
  new ClipboardJS("#clipboard-btn")
})
