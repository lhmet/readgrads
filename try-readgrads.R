data_tmp <- tempfile(fileext = '.bin')
download.file(
  "http://ftp.cptec.inpe.br/modelos/io/produtos/MERGE/2020/prec_20200101.bin",
  data_tmp
)
ctl_tmp <- file.path(dirname(data_tmp), gsub('.bin', '.ctl', basename(data_tmp)))
download.file(
  "http://ftp.cptec.inpe.br/modelos/io/produtos/MERGE/2020/prec_20200101.ctl",
  ctl_tmp
)

library(tidyverse)

x <- readGradsFile(
  data_tmp, 
  file.ext = ".bin" ,
  convert2dataframe = TRUE,
  #varname = "prec",
  padding.bytes = FALSE
) %>% as_tibble

y <- x %>%
  tidyr::pivot_wider(names_from = "variable", values_from ="value", id_cols = -index) %>%
  mutate
y
# grid points with stations
nrow(filter(y, !is.na(nest), nest >= 0))