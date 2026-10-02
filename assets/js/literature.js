// Literature table: sort by any column, filter by tags.
// Selected tags are kept in the address (#tags=a,b) so a filtered list can be shared.
(function () {
  var root = document.querySelector("[data-literature]");
  if (!root) return;

  var tbody = root.querySelector("tbody");
  var rows = Array.prototype.slice.call(tbody.rows);
  var count = root.querySelector("[data-count]");
  var clear = root.querySelector("[data-clear]");
  var empty = root.querySelector("[data-empty]");
  var collator = new Intl.Collator(document.documentElement.lang || "de", { sensitivity: "base", numeric: true });
  var selected = [];
  var sortKey = "author";
  var sortDir = 1;

  // ---- sorting ----

  function value(row, key) {
    return row.getAttribute("data-" + key) || "";
  }

  function compare(a, b) {
    var va = value(a, sortKey), vb = value(b, sortKey);
    // empty values (no year, no tags) always go last
    if (!va || !vb) return va ? -1 : (vb ? 1 : 0);
    var result = sortKey === "year" ? Number(va) - Number(vb) : collator.compare(va, vb);
    // ties: by author, then title
    if (result === 0 && sortKey !== "author") result = collator.compare(value(a, "author"), value(b, "author"));
    if (result === 0) result = collator.compare(value(a, "title"), value(b, "title"));
    return result * sortDir;
  }

  function sort() {
    rows.sort(compare);
    rows.forEach(function (row) { tbody.appendChild(row); });
    root.querySelectorAll("th").forEach(function (th) {
      var key = th.querySelector("[data-sort]").getAttribute("data-sort");
      if (key === sortKey) th.setAttribute("aria-sort", sortDir > 0 ? "ascending" : "descending");
      else th.removeAttribute("aria-sort");
    });
  }

  root.querySelectorAll("[data-sort]").forEach(function (button) {
    button.addEventListener("click", function () {
      var key = button.getAttribute("data-sort");
      sortDir = key === sortKey ? -sortDir : 1;
      sortKey = key;
      sort();
    });
  });

  // ---- tag filter: an entry is shown if it has all selected tags ----

  function filter() {
    var visible = 0;
    rows.forEach(function (row) {
      var tags = value(row, "tags").split("|");
      var match = selected.every(function (t) { return tags.indexOf(t) !== -1; });
      row.hidden = !match;
      if (match) visible++;
    });
    root.querySelectorAll(".tag[data-tag]").forEach(function (button) {
      button.setAttribute("aria-pressed", selected.indexOf(button.getAttribute("data-tag")) !== -1);
    });
    if (count) count.textContent = visible;
    if (clear) clear.hidden = selected.length === 0;
    if (empty) empty.hidden = visible > 0;
    var hash = selected.length ? "#tags=" + selected.map(encodeURIComponent).join(",") : "";
    history.replaceState(null, "", location.pathname + location.search + hash);
  }

  root.addEventListener("click", function (event) {
    var button = event.target.closest(".tag[data-tag]");
    if (!button) return;
    var tag = button.getAttribute("data-tag");
    var i = selected.indexOf(tag);
    if (i === -1) selected.push(tag); else selected.splice(i, 1);
    filter();
  });

  if (clear) clear.addEventListener("click", function () {
    selected = [];
    filter();
  });

  // #tags=a,b in the address selects tags (on load and when a link changes it)
  function readHash() {
    var match = location.hash.match(/^#tags=(.+)$/);
    selected = match ? match[1].split(",").map(decodeURIComponent) : [];
    filter();
  }
  window.addEventListener("hashchange", readHash);
  if (location.hash) readHash();
})();
