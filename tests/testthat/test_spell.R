path_package <- if (Sys.getenv("_R_CHECK_PACKAGE_NAME_") != "") {
      path.package(Sys.getenv("_R_CHECK_PACKAGE_NAME_"))
    } else {
      "."
    }
pkg <- devtools::as.package(path_package)

context("spell checking (root files and documentation)")
test_that("misspelling", {
  spell_error <- spelling::spell_check_package(pkg, vignettes = TRUE, use_wordlist = TRUE)
  expect(
      nrow(spell_error) == 0,
      failure_message = apply(spell_error, 1,
              function(word) paste0("\nmisspelled word '", word[1], "' in ", word[2])) %>%
          paste(collapse = "")
  )

})
