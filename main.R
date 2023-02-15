suppressPackageStartupMessages({
  library(tercen)
  library(dplyr)
  library(DESeq2)
  library(tidyr)
})

ctx = tercenCtx()

if(length(ctx$yAxis) == 0) stop("y axis is missing.")
if(length(ctx$rnames) == 0) stop("row information is missing.")
if(length(ctx$cnames) == 0) stop("column information is missing.")
if(length(ctx$colors) == 0) stop("color information is missing.")

blind <- ctx$op.value('blind', as.logical, FALSE)

all_data <- ctx %>% select(.y, .ci, .ri, .colorLevels)

count_matrix <- all_data %>%
  select(.y, .ri, .ci) %>%
  pivot_wider(names_from = ".ci", values_from = ".y") %>%
  select(-.ri) %>%
  as.matrix()

colData <- filter(all_data, .ri == 0) %>%
  select(.ci, condition = .colorLevels) %>%
  mutate(condition = as.factor(condition))

dds <- DESeqDataSetFromMatrix(
  countData = count_matrix,
  colData = colData,
  design = ~ condition
)

vsd <- assay(varianceStabilizingTransformation(dds, blind = blind))

df_out <- as_tibble(vsd) %>%
  mutate(.ri = row_number() - 1L) %>%
  pivot_longer(-.ri, names_to = ".ci", values_to = "vsd") %>%
  mutate(.ci = as.integer(.ci)) %>%
  ctx$addNamespace()

ctx$save(df_out)
