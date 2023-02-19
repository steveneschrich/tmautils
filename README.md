# tmautils
An R package for managing tissue microarray (TMA) data. This type of data is relatively low density molecular readouts consisting of individual tissue cores arranged on a slide for antibody-based evaluation of target expression. Traditionally, these cores were evaluated by a pathologist and scored according to intensity of stain and/or percentage of the cells in the core that were stained. This package provides some tools for managing this type of data. Note these are data management utilities rather than analytical utilities.

# Installing
This package is currently available on github as an R package. To install, 
```
devtools::install_github("steveneschrich/tmautils")
```

# Key Functionality
There are two main functions for this package (currently): `core2map()` and `find_tma_alignment()`. 

- `core2map()` will display a value field (for instance, intensity or core name) in the 2D arrangement defined by the
TMA (rows and columns).
- `find_tma_alignment()` will try to orient a particular TMA result with a reference orientation. Multiple stains can be performed on the same TMA, but often the orientations differ over time. This tries to find the correction (re)orientation of the new result back to the original orientation.

## Data Representation
The library assumes that the TMA data is represented as a **flat data frame** consisting of one row per observation. That is, something of the form:

|Row|Col| Intensity |
|---|---|-----|
|Row1|Col1|Val1|
|Row1|Col2|Val2|
|Row2|Col1|Val3|
|Row2|Col2|Val4|

This is very different from what one might normally think of a TMA as:

| TMA| Col1 | Col2 |
|---|---|---|
|RowA| Val1 | Val2 |
|RowB| Val3 | Val4 |

However, there are several key advantages:

- Data analysis post-QC becomes easier since the data is a table of observations (e.g., intensity) rather than a 2D matrix of intensities.
- Reorientation (when row/col coordinates must be changed) is less impactful to downstream analysis
- Multiple measurements per core are just additional rows in the table. In particular, associating a `core id` to a particular position means the analysis is more typical (one observation/patient with multiple measurements).
