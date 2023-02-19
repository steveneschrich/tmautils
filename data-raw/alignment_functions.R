## code to prepare `alignment_functions` dataset goes here

alignment_functions <- list(
  quote(I),
  quote(rev),
  quote(\(.x) rev(td(.x))),
  quote(\(.x) rev(td(rev(.x)))),
  quote(\(.x) td(.x)),
  quote(\(.x) td(rev(.x))),
  quote(\(.x) td(rev(td(.x)))),
  quote(\(.x) td(rev(td(rev(.x)))))
)
alignment_functions <- setNames(alignment_functions, alignment_functions)
usethis::use_data(alignment_functions, overwrite = TRUE)
