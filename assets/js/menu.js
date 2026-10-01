// Main category dropdown in the start page header: closes on a click outside or Esc.
var menu = document.querySelector(".menu");

if (menu) {
  document.addEventListener("click", function (event) {
    if (!menu.contains(event.target)) menu.open = false;
  });
  document.addEventListener("keydown", function (event) {
    if (event.key === "Escape" && menu.open) {
      menu.open = false;
      menu.querySelector("summary").focus();
    }
  });
}
