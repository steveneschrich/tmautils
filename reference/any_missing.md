# Test if any elements of data frame are na

Test if any elements of data frame are na

## Usage

``` r
any_missing(.x)
```

## Arguments

- .x:

  data frame

## Value

A logical indicating if any elements are na

## Examples

``` r
if (FALSE) { # \dontrun{
any_missing(data.frame(A=c(1,2,3),B=c(2,NA,4)))
# returns [1] TRUE
} # }
```
