// Boighor Digital Library

document.addEventListener("DOMContentLoaded", () => {

  // Mobile menu
  const menuButton = document.querySelector("#menuButton");
  const menu = document.querySelector("#mobileMenu");

  if (menuButton && menu) {
    menuButton.addEventListener("click", () => {
      menu.classList.toggle("is-open");
    });
  }

  // Book search
  const searchInput = document.querySelector("#bookSearch");
  const books = document.querySelectorAll(".book-card");

  if (searchInput) {
    searchInput.addEventListener("input", () => {
      const searchText = searchInput.value.toLowerCase();

      books.forEach((book) => {
        const bookText = book.textContent.toLowerCase();

        book.style.display =
          bookText.includes(searchText) ? "" : "none";
      });
    });
  }

  // Password visibility
  document.querySelectorAll("[data-toggle-password]").forEach((button) => {
    button.addEventListener("click", () => {
      const field = document.querySelector(
        button.getAttribute("data-toggle-password")
      );

      if (field) {
        field.type =
          field.type === "password" ? "text" : "password";
      }
    });
  });

  console.log("Boighor Library Loaded Successfully!");
});
