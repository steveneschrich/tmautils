# Alignment function list

A list of alignments that rotate/flip a matrix.

## Usage

``` r
alignment_functions
```

## Format

An object of class `list` of length 8.

## Details

Sometimes a TMA result will be captured in a different orientation from
the initial design description. In this case, row and column numbers
will not refer back to the correct location. There are markers (blanks)
on many TMAs which can help orient the result back to the design.

This list is a set of operators that can be applied to a matrix to
rotate and/or flip a matrix into different orientations. It consists of
different transpose and reverse operators in different orders to
generate the various permutations.

Note that the contents of the list are quoted functions, so you can
print out the function. If you would like to use the function, you would
need to use [`base::eval()`](https://rdrr.io/r/base/eval.html) to
evaluate it.
