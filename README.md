# VST

##### Description

`vst_operator` performs the variance stabilising transformation on count data using the `DESeq2` package from BioConductor (Love, et al, Genome Biology, 2014).

##### Usage

| Input projection | Description                      |
| ---------------- | -------------------------------- |
| `row`            | Gene name/identifier             |
| `column`         | Sample name/identifier           |
| `color`          | Represents the groups to compare |
| `y-axis`         | Sequence counts                  |

| Input parameters | Description                                                                              |
| -----------------| ---------------------------------------------------------------------------------------- |
| `blind`  | Logical, whether the transformation should be blind to the experimental factors (default = FALSE) |

|  Output relations  | Description                                                                |
| ------------------ | -------------------------------------------------------------------------- |
| `vsd`           | numeric, the variance stabilized values                                       |

##### Details

The operator uses the `DESeq2` package from BioConductor.

##### References

Love MI, Huber W, Anders S (2014). “Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2.” Genome Biology, 15, 550. doi: 10.1186/s13059-014-0550-8.

See ["Analyzing RNA-seq data with DESeq2"](https://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html) for further information on DESeq2 by Love, et al.


