// Keyboard navigation on detail pages: Esc closes, arrow keys go to previous / next example.
document.addEventListener("keydown", function (event) {
  if (event.metaKey || event.ctrlKey || event.altKey) return;
  var link = document.querySelector('[data-key="' + event.key + '"]');
  if (link) window.location.href = link.href;
});
