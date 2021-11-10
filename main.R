library(tercen)
library(dplyr)
library(DESeq2)
library(tidyr)

options("tercen.workflowId" = "e20dce0618dceee40baff0f67f003513")
options("tercen.stepId"     = "58c046df-2126-49f0-b498-2c2a5d61dc5c")

getOption("tercen.workflowId")
getOption("tercen.stepId")

ctx = tercenCtx()

if(length(ctx$yAxis) == 0) stop("y axis is missing.")
if(length(ctx$rnames) == 0) stop("row information is missing.")
if(length(ctx$cnames) == 0) stop("column information is missing.")
if(length(ctx$colors) == 0) stop("color information is missing.")

blind <- as.logical(ctx$op.value('blind'))


all_data <- ctx %>% select(.ci, .ri,.colorLevels)

count_matrix <- ctx$as.matrix()

colData <- filter(all_data, .ri == 0) %>%
  select(.ci, condition = .colorLevels)

dds <- DESeqDataSetFromMatrix(countData = count_matrix,
                              colData = colData,
                              design = ~ condition)

vsd <- assay(vst(dds, blind=blind))

vsd <- as_tibble(vsd) %>%
  mutate(.ri = row_number() - 1) %>%
  pivot_longer(-.ri, names_to = ".ci", values_to = "vsd") %>%
  mutate(.ci = as.integer(.ci) - 1)

ctx$addNamespace(vsd) %>%
  ctx$save()
