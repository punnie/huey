// Huey application javascript

const units = {
  year  : 24 * 60 * 60 * 1000 * 365,
  month : 24 * 60 * 60 * 1000 * 365/12,
  day   : 24 * 60 * 60 * 1000,
  hour  : 60 * 60 * 1000,
  minute: 60 * 1000,
  second: 1000
}

const rtf = new Intl.RelativeTimeFormat("en", { numeric: "auto" })

document.addEventListener("DOMContentLoaded", (event) => {
  let backToTopButton = document.getElementById("back-to-top-button");

  let displayBackToTopButton = () => {
    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
      backToTopButton.style.display = "block";
    } else {
      backToTopButton.style.display = "none";
    }
  }

  let backToTop = () => {
    document.documentElement.scrollIntoView({ behavior: "smooth" })
  }

  backToTopButton.onclick = backToTop;

  window.onscroll = function () {
    displayBackToTopButton();
  };

  let getRelativeTime = (d1, d2 = new Date()) => {
    var elapsed = d1 - d2;

    // "Math.abs" accounts for both "past" & "future" scenarios
    for (var u in units) {
      if (Math.abs(elapsed) > units[u] || u == "second") {
        return rtf.format(Math.round(elapsed/units[u]), u)
      }
    }
  }

  let updateTimestamps = () => {
    document.querySelectorAll("p[data-relative-timestamp]").forEach((element) => {
      let elementTimestamp = element.dataset.relativeTimestamp;
      let newRelativeTimestamp = getRelativeTime(elementTimestamp);

      element.innerHTML = newRelativeTimestamp;
    })
  }

  // Update timestamps every minute
  setInterval(updateTimestamps, 60 * 1000);

  // Update timestamps when the window is focused (tab opened, etc)
  window.addEventListener("focus", updateTimestamps);
});

