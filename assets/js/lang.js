// Language switch on the start page: EN / DE, remembered for the detail pages.
var langButtons = document.querySelectorAll(".lang-switch [data-lang]");

function setLang(lang) {
  if (lang === "en") delete document.documentElement.dataset.lang;
  else document.documentElement.dataset.lang = lang;
  langButtons.forEach(function (b) { b.setAttribute("aria-pressed", b.dataset.lang === lang); });
}

setLang(document.documentElement.dataset.lang || "en");
langButtons.forEach(function (button) {
  button.addEventListener("click", function () {
    setLang(button.dataset.lang);
    try { localStorage.setItem("lang", button.dataset.lang); } catch (e) {}
  });
});
