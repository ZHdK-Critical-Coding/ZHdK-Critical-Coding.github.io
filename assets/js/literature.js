// Literature table: sort by any column, filter by categories and tags.
// An entry is shown if it matches all selected filters. Filters without a
// match for the current selection are disabled. The selection is kept in the
// address (#filter=cat:…,tag:…) so a filtered list can be shared.
(function () {
  var root = document.querySelector("[data-literature]");
  if (!root) return;

  var tbody = root.querySelector("tbody");
  var rows = Array.prototype.slice.call(tbody.rows);
  var count = document.querySelector("[data-count]");  // right of the intro
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

  // ---- filters: "tag:Design", "cat:Medientheorie", "cat:Medientheorie › Black Box" ----

  var filterButtons = root.querySelectorAll("[data-filter]");
  var barButtons = root.querySelectorAll(".tag-filter [data-filter]");
  var rowFilters = rows.map(function (row) { return value(row, "filters").split("|"); });

  function matches(i, filters) {
    return filters.every(function (f) { return rowFilters[i].indexOf(f) !== -1; });
  }

  function filter() {
    var visible = 0;
    rows.forEach(function (row, i) {
      row.hidden = !matches(i, selected);
      if (!row.hidden) visible++;
    });
    filterButtons.forEach(function (button) {
      button.setAttribute("aria-pressed", selected.indexOf(button.getAttribute("data-filter")) !== -1);
    });
    // a filter that would leave no entries is disabled (selected ones stay usable)
    barButtons.forEach(function (button) {
      var f = button.getAttribute("data-filter");
      if (selected.indexOf(f) !== -1) { button.disabled = false; return; }
      var n = 0;
      rows.forEach(function (row, i) { if (!row.hidden && rowFilters[i].indexOf(f) !== -1) n++; });
      button.disabled = n === 0;
      button.title = n + (n === 1 ? " entry" : " entries");
    });
    if (count) count.textContent = visible;
    if (clear) clear.hidden = selected.length === 0;
    if (empty) empty.hidden = visible > 0;
    var hash = selected.length ? "#filter=" + selected.map(encodeURIComponent).join(",") : "";
    history.replaceState(null, "", location.pathname + location.search + hash);
  }

  root.addEventListener("click", function (event) {
    var button = event.target.closest("[data-filter]");
    if (!button || button.disabled) return;
    var f = button.getAttribute("data-filter");
    var i = selected.indexOf(f);
    if (i === -1) selected.push(f); else selected.splice(i, 1);
    filter();
  });

  if (clear) clear.addEventListener("click", function () {
    selected = [];
    filter();
  });

  // #filter=… in the address selects filters (#tags=a,b from older links too)
  function readHash() {
    var match = location.hash.match(/^#(filter|tags)=(.+)$/);
    selected = match ? match[2].split(",").map(decodeURIComponent).map(function (f) {
      return match[1] === "tags" ? "tag:" + f : f;
    }) : [];
    filter();
  }
  window.addEventListener("hashchange", readHash);
  if (location.hash) readHash(); else filter();
})();
