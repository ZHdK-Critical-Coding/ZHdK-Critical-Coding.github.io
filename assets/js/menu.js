// Dropdowns in the site header: only one is open at a time,
// a click outside or Esc closes them.
var menus = Array.prototype.slice.call(document.querySelectorAll(".menu"));

menus.forEach(function (menu) {
  menu.addEventListener("toggle", function () {
    if (!menu.open) return;
    menus.forEach(function (other) { if (other !== menu) other.open = false; });
  });
});

document.addEventListener("click", function (event) {
  menus.forEach(function (menu) {
    if (!menu.contains(event.target)) menu.open = false;
  });
});

document.addEventListener("keydown", function (event) {
  if (event.key !== "Escape") return;
  menus.forEach(function (menu) {
    if (menu.open) {
      menu.open = false;
      menu.querySelector("summary").focus();
    }
  });
});
