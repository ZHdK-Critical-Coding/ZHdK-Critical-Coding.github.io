// Direction of the card-flip page transition (see style.css).
// Links marked data-flip="back" (close, previous example) flip the other way.
// The outgoing page decides, the incoming page (where the animation runs) applies it.
window.addEventListener("pageswap", function (event) {
  if (!event.viewTransition || !event.activation) return;
  var to = event.activation.entry.url;
  var back = Array.prototype.some.call(document.querySelectorAll('[data-flip="back"]'), function (link) {
    return link.href === to;
  });
  try { sessionStorage.setItem("flip", back ? "back" : "forward"); } catch (e) {}
});

window.addEventListener("pagereveal", function (event) {
  if (!event.viewTransition) return;
  var direction = null;
  try {
    direction = sessionStorage.getItem("flip");
    sessionStorage.removeItem("flip");
  } catch (e) {}
  if (direction === "back") event.viewTransition.types.add("flip-back");
});
