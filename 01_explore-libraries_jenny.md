---
output: 
  html_document: default
  pdf_document: default
  word_document: 
    keep_md: true
title: Tidy version of Jenny's code
author: "Mik Black"
date: "2 Jan 2018"
---


```r
## Load packages
library(fs)
library(tidyverse)

## how jenny might do this in a first exploration
## purposely leaving a few things to change later!
```

Which libraries does R search for packages?


```r
.libPaths()
```

```
## [1] "/Library/Frameworks/R.framework/Versions/3.4/Resources/library"
```

```r
## let's confirm the second element is, in fact, the default library
.Library
```

```
## [1] "/Library/Frameworks/R.framework/Resources/library"
```

```r
path_real(.Library)
```

```
## /Library/Frameworks/R.framework/Versions/3.4/Resources/library
```

Installed packages


```r
ipt <- installed.packages() %>%
  as_tibble()

## how many packages?
nrow(ipt)
```

```
## [1] 465
```

Exploring the packages


```r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
ipt %>%
  count(LibPath, Priority)
```

```
## # A tibble: 3 x 3
##   LibPath                                                 Priority       n
##   <chr>                                                   <chr>      <int>
## 1 /Library/Frameworks/R.framework/Versions/3.4/Resources… base          14
## 2 /Library/Frameworks/R.framework/Versions/3.4/Resources… recommend…    15
## 3 /Library/Frameworks/R.framework/Versions/3.4/Resources… <NA>         436
```

```r
##   * what proportion need compilation?
ipt %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
```

```
## # A tibble: 3 x 3
##   NeedsCompilation     n   prop
##   <chr>            <int>  <dbl>
## 1 no                 232 0.499 
## 2 yes                210 0.452 
## 3 <NA>                23 0.0495
```

```r
##   * how break down re: version of R they were built on
ipt %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

```
## # A tibble: 5 x 3
##   Built     n   prop
##   <chr> <int>  <dbl>
## 1 3.3.2     6 0.0129
## 2 3.4.0   166 0.357 
## 3 3.4.1    39 0.0839
## 4 3.4.2   106 0.228 
## 5 3.4.3   148 0.318
```

Reflections


```r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
```

Going further


```r
## if you have time to do more ...

## is every package in .Library either base or recommended?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- ipt %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)
```

```
##   [1] "00LOCK-WGCNA"                       
##   [2] "abind"                              
##   [3] "acepack"                            
##   [4] "ade4"                               
##   [5] "affxparser"                         
##   [6] "affy"                               
##   [7] "affycoretools"                      
##   [8] "affyio"                             
##   [9] "affyPLM"                            
##  [10] "affyQCReport"                       
##  [11] "AIMS"                               
##  [12] "amap"                               
##  [13] "annotate"                           
##  [14] "AnnotationDbi"                      
##  [15] "AnnotationFilter"                   
##  [16] "AnnotationForge"                    
##  [17] "AnnotationHub"                      
##  [18] "apc"                                
##  [19] "ape"                                
##  [20] "assertthat"                         
##  [21] "backports"                          
##  [22] "base64enc"                          
##  [23] "BH"                                 
##  [24] "BiasedUrn"                          
##  [25] "bindr"                              
##  [26] "bindrcpp"                           
##  [27] "Biobase"                            
##  [28] "BiocGenerics"                       
##  [29] "BiocInstaller"                      
##  [30] "BiocParallel"                       
##  [31] "BiocStyle"                          
##  [32] "biomaRt"                            
##  [33] "Biostrings"                         
##  [34] "biovizBase"                         
##  [35] "bit"                                
##  [36] "bit64"                              
##  [37] "bitops"                             
##  [38] "blob"                               
##  [39] "bookdown"                           
##  [40] "bootstrap"                          
##  [41] "breastCancerMAINZ"                  
##  [42] "breastCancerNKI"                    
##  [43] "breastCancerTRANSBIG"               
##  [44] "breastCancerUNT"                    
##  [45] "breastCancerUPP"                    
##  [46] "brew"                               
##  [47] "broom"                              
##  [48] "BSgenome"                           
##  [49] "car"                                
##  [50] "carData"                            
##  [51] "Category"                           
##  [52] "caTools"                            
##  [53] "cats"                               
##  [54] "cellranger"                         
##  [55] "cgdsr"                              
##  [56] "checkmate"                          
##  [57] "clariomdhumantranscriptcluster.db"  
##  [58] "clariomshumanhttranscriptcluster.db"
##  [59] "cli"                                
##  [60] "clipr"                              
##  [61] "clisymbols"                         
##  [62] "cmprsk"                             
##  [63] "coda"                               
##  [64] "colorRamps"                         
##  [65] "colorspace"                         
##  [66] "combinat"                           
##  [67] "commonmark"                         
##  [68] "config"                             
##  [69] "corpcor"                            
##  [70] "corrr"                              
##  [71] "covTest"                            
##  [72] "cowplot"                            
##  [73] "crayon"                             
##  [74] "crosstalk"                          
##  [75] "crrstep"                            
##  [76] "curl"                               
##  [77] "data.table"                         
##  [78] "data.tree"                          
##  [79] "DBI"                                
##  [80] "dbplyr"                             
##  [81] "debugme"                            
##  [82] "DelayedArray"                       
##  [83] "dendextend"                         
##  [84] "DEoptimR"                           
##  [85] "desc"                               
##  [86] "DESeq2"                             
##  [87] "deSolve"                            
##  [88] "devtools"                           
##  [89] "DiagrammeR"                         
##  [90] "dichromat"                          
##  [91] "digest"                             
##  [92] "diptest"                            
##  [93] "DNAcopy"                            
##  [94] "doParallel"                         
##  [95] "downloader"                         
##  [96] "dplyr"                              
##  [97] "DT"                                 
##  [98] "dynamicTreeCut"                     
##  [99] "e1071"                              
## [100] "ecoli2.db"                          
## [101] "ecolicdf"                           
## [102] "ecoliLeucine"                       
## [103] "edgeR"                              
## [104] "effects"                            
## [105] "enc"                                
## [106] "enrichR"                            
## [107] "EnsDb.Hsapiens.v75"                 
## [108] "EnsDb.Hsapiens.v79"                 
## [109] "EnsDb.Hsapiens.v86"                 
## [110] "ensembldb"                          
## [111] "epitools"                           
## [112] "evaluate"                           
## [113] "exactRankTests"                     
## [114] "extrafont"                          
## [115] "extrafontdb"                        
## [116] "fastcluster"                        
## [117] "fBasics"                            
## [118] "ff"                                 
## [119] "fit.models"                         
## [120] "flexdashboard"                      
## [121] "flexmix"                            
## [122] "FNN"                                
## [123] "forcats"                            
## [124] "foreach"                            
## [125] "formatR"                            
## [126] "Formula"                            
## [127] "fpc"                                
## [128] "fs"                                 
## [129] "futile.logger"                      
## [130] "futile.options"                     
## [131] "gap"                                
## [132] "gclus"                              
## [133] "gcrma"                              
## [134] "gdata"                              
## [135] "gdsfmt"                             
## [136] "geigen"                             
## [137] "gelnet"                             
## [138] "genefilter"                         
## [139] "genefu"                             
## [140] "geneLenDataBase"                    
## [141] "geneplotter"                        
## [142] "genetics"                           
## [143] "GeneticsDesign"                     
## [144] "GeneticsPed"                        
## [145] "GenomeInfoDb"                       
## [146] "GenomeInfoDbData"                   
## [147] "GenomicAlignments"                  
## [148] "GenomicFeatures"                    
## [149] "GenomicFiles"                       
## [150] "GenomicRanges"                      
## [151] "GGally"                             
## [152] "ggbio"                              
## [153] "ggdendro"                           
## [154] "ggplot2"                            
## [155] "ggpubr"                             
## [156] "ggrepel"                            
## [157] "ggsci"                              
## [158] "ggsignif"                           
## [159] "ggvis"                              
## [160] "gh"                                 
## [161] "git2r"                              
## [162] "glmnet"                             
## [163] "glmpath"                            
## [164] "glue"                               
## [165] "gmodels"                            
## [166] "GO.db"                              
## [167] "goseq"                              
## [168] "GOstats"                            
## [169] "gplots"                             
## [170] "graph"                              
## [171] "graphite"                           
## [172] "gridBase"                           
## [173] "gridExtra"                          
## [174] "GSA"                                
## [175] "GSEABase"                           
## [176] "gss"                                
## [177] "gtable"                             
## [178] "gtools"                             
## [179] "Gviz"                               
## [180] "haven"                              
## [181] "here"                               
## [182] "heritability"                       
## [183] "hexbin"                             
## [184] "HGNChelper"                         
## [185] "hgu133a.db"                         
## [186] "hgu133plus2.db"                     
## [187] "hgu133plus2cdf"                     
## [188] "highr"                              
## [189] "Hmisc"                              
## [190] "hms"                                
## [191] "htmlTable"                          
## [192] "htmltools"                          
## [193] "htmlwidgets"                        
## [194] "httpuv"                             
## [195] "httr"                               
## [196] "hwriter"                            
## [197] "iC10"                               
## [198] "iC10TrainingData"                   
## [199] "igraph"                             
## [200] "illuminaHumanv4.db"                 
## [201] "impute"                             
## [202] "influenceR"                         
## [203] "ini"                                
## [204] "interactiveDisplayBase"             
## [205] "intervals"                          
## [206] "ipred"                              
## [207] "IRanges"                            
## [208] "irlba"                              
## [209] "ismev"                              
## [210] "ISR3"                               
## [211] "iterators"                          
## [212] "jsonlite"                           
## [213] "KEGG.db"                            
## [214] "kernlab"                            
## [215] "kinship2"                           
## [216] "km.ci"                              
## [217] "KMsurv"                             
## [218] "knitr"                              
## [219] "ks"                                 
## [220] "labeling"                           
## [221] "lambda.r"                           
## [222] "lars"                               
## [223] "latticeExtra"                       
## [224] "lava"                               
## [225] "lazyeval"                           
## [226] "limma"                              
## [227] "lme4"                               
## [228] "locfit"                             
## [229] "lubridate"                          
## [230] "magick"                             
## [231] "magrittr"                           
## [232] "markdown"                           
## [233] "MatrixModels"                       
## [234] "matrixStats"                        
## [235] "maxstat"                            
## [236] "mclust"                             
## [237] "mco"                                
## [238] "memoise"                            
## [239] "mGSZ"                               
## [240] "mice"                               
## [241] "MIGSA"                              
## [242] "miktools"                           
## [243] "mime"                               
## [244] "minqa"                              
## [245] "misc3d"                             
## [246] "mitools"                            
## [247] "mnormt"                             
## [248] "modelr"                             
## [249] "modeltools"                         
## [250] "mogsa"                              
## [251] "msa"                                
## [252] "multicool"                          
## [253] "multtest"                           
## [254] "munsell"                            
## [255] "mvtnorm"                            
## [256] "nloptr"                             
## [257] "NLP"                                
## [258] "NMF"                                
## [259] "nortest"                            
## [260] "numDeriv"                           
## [261] "OceanView"                          
## [262] "oligo"                              
## [263] "oligoClasses"                       
## [264] "openssl"                            
## [265] "org.EcK12.eg.db"                    
## [266] "org.Hs.eg.db"                       
## [267] "org.Sc.sgd.db"                      
## [268] "OrganismDbi"                        
## [269] "pamr"                               
## [270] "pbkrtest"                           
## [271] "pcaPP"                              
## [272] "pd.clariom.d.human"                 
## [273] "pd.hta.2.0"                         
## [274] "pedicure"                           
## [275] "permute"                            
## [276] "PFAM.db"                            
## [277] "pillar"                             
## [278] "pkgconfig"                          
## [279] "pkgmaker"                           
## [280] "PKI"                                
## [281] "plogr"                              
## [282] "plot3D"                             
## [283] "plot3Drgl"                          
## [284] "plotly"                             
## [285] "plotrix"                            
## [286] "plyr"                               
## [287] "prabclus"                           
## [288] "praise"                             
## [289] "preprocessCore"                     
## [290] "prettyunits"                        
## [291] "pROC"                               
## [292] "processx"                           
## [293] "prodlim"                            
## [294] "progress"                           
## [295] "ProtGenerics"                       
## [296] "psych"                              
## [297] "purrr"                              
## [298] "pwr"                                
## [299] "qap"                                
## [300] "qtl"                                
## [301] "quadprog"                           
## [302] "quantreg"                           
## [303] "QuasR"                              
## [304] "R.methodsS3"                        
## [305] "R.oo"                               
## [306] "R.utils"                            
## [307] "R6"                                 
## [308] "rappdirs"                           
## [309] "raster"                             
## [310] "RBGL"                               
## [311] "Rbowtie"                            
## [312] "Rcmdr"                              
## [313] "RcmdrMisc"                          
## [314] "RColorBrewer"                       
## [315] "Rcpp"                               
## [316] "RcppArmadillo"                      
## [317] "RcppEigen"                          
## [318] "RCurl"                              
## [319] "reactome.db"                        
## [320] "readr"                              
## [321] "readstata13"                        
## [322] "readxl"                             
## [323] "registry"                           
## [324] "relimp"                             
## [325] "rematch"                            
## [326] "rematch2"                           
## [327] "ReportingTools"                     
## [328] "reshape"                            
## [329] "reshape2"                           
## [330] "reticulate"                         
## [331] "rgdal"                              
## [332] "rgexf"                              
## [333] "rgl"                                
## [334] "Rgraphviz"                          
## [335] "rjags"                              
## [336] "rjson"                              
## [337] "RJSONIO"                            
## [338] "rlang"                              
## [339] "rmarkdown"                          
## [340] "rmeta"                              
## [341] "RMySQL"                             
## [342] "rngtools"                           
## [343] "robust"                             
## [344] "robustbase"                         
## [345] "Rook"                               
## [346] "roxygen2"                           
## [347] "rprojroot"                          
## [348] "Rqc"                                
## [349] "rrBLUP"                             
## [350] "rrcov"                              
## [351] "Rsamtools"                          
## [352] "RSQLite"                            
## [353] "rstudioapi"                         
## [354] "Rsubread"                           
## [355] "rsvd"                               
## [356] "rtracklayer"                        
## [357] "Rttf2pt1"                           
## [358] "rvest"                              
## [359] "S4Vectors"                          
## [360] "safe"                               
## [361] "sandwich"                           
## [362] "scales"                             
## [363] "scatterplot3d"                      
## [364] "secure"                             
## [365] "segmented"                          
## [366] "selectiveInference"                 
## [367] "selectr"                            
## [368] "seqinr"                             
## [369] "seriation"                          
## [370] "shape"                              
## [371] "shiny"                              
## [372] "ShortRead"                          
## [373] "simecol"                            
## [374] "simpleaffy"                         
## [375] "SiMRiv"                             
## [376] "slackr"                             
## [377] "slam"                               
## [378] "slidify"                            
## [379] "slidifyLibraries"                   
## [380] "snow"                               
## [381] "SNPlocs.Hsapiens.dbSNP144.GRCh37"   
## [382] "SNPRelate"                          
## [383] "sourcetools"                        
## [384] "sp"                                 
## [385] "SparseM"                            
## [386] "SQUAREM"                            
## [387] "stabledist"                         
## [388] "statmod"                            
## [389] "stencila"                           
## [390] "stringi"                            
## [391] "stringr"                            
## [392] "styler"                             
## [393] "SummarizedExperiment"               
## [394] "SuppDists"                          
## [395] "survcomp"                           
## [396] "survey"                             
## [397] "survivalROC"                        
## [398] "survminer"                          
## [399] "survMisc"                           
## [400] "svd"                                
## [401] "svgPanZoom"                         
## [402] "tcltk2"                             
## [403] "tensorflow"                         
## [404] "testit"                             
## [405] "testthat"                           
## [406] "texPreview"                         
## [407] "tfruns"                             
## [408] "tibble"                             
## [409] "tidyr"                              
## [410] "tidyselect"                         
## [411] "tidyverse"                          
## [412] "timeDate"                           
## [413] "timeSeries"                         
## [414] "tm"                                 
## [415] "tm.plugin.mail"                     
## [416] "translations"                       
## [417] "trimcluster"                        
## [418] "TSP"                                
## [419] "usethis"                            
## [420] "utf8"                               
## [421] "VariantAnnotation"                  
## [422] "vegan"                              
## [423] "viridis"                            
## [424] "viridisLite"                        
## [425] "visNetwork"                         
## [426] "vtreat"                             
## [427] "WGCNA"                              
## [428] "whisker"                            
## [429] "withr"                              
## [430] "wordcloud"                          
## [431] "xfun"                               
## [432] "XML"                                
## [433] "xml2"                               
## [434] "xtable"                             
## [435] "XVector"                            
## [436] "yaml"                               
## [437] "zlibbioc"                           
## [438] "zoo"
```

```r
## study package naming style (all lower case, contains '.', etc

## use `fields` argument to installed.packages() to get more info and use it!
ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))
```

```
## # A tibble: 2 x 3
##   github     n  prop
##   <lgl>  <int> <dbl>
## 1 F        316 0.680
## 2 T        149 0.320
```

```r
devtools::session_info()
```

```
## Session info -------------------------------------------------------------
```

```
##  setting  value                       
##  version  R version 3.4.3 (2017-11-30)
##  system   x86_64, darwin15.6.0        
##  ui       RStudio (1.1.419)           
##  language (EN)                        
##  collate  en_NZ.UTF-8                 
##  tz       Pacific/Auckland            
##  date     2018-02-01
```

```
## Packages -----------------------------------------------------------------
```

```
##  package    * version date       source        
##  assertthat   0.2.0   2017-04-11 CRAN (R 3.4.0)
##  backports    1.1.2   2017-12-13 CRAN (R 3.4.3)
##  base       * 3.4.3   2017-12-07 local         
##  bindr        0.1     2016-11-13 CRAN (R 3.4.0)
##  bindrcpp   * 0.2     2017-06-17 CRAN (R 3.4.0)
##  broom        0.4.3   2017-11-20 CRAN (R 3.4.3)
##  cellranger   1.1.0   2016-07-27 CRAN (R 3.4.0)
##  cli          1.0.0   2017-11-05 CRAN (R 3.4.2)
##  colorspace   1.3-2   2016-12-14 CRAN (R 3.4.0)
##  compiler     3.4.3   2017-12-07 local         
##  crayon       1.3.4   2017-09-16 CRAN (R 3.4.1)
##  datasets   * 3.4.3   2017-12-07 local         
##  devtools     1.13.4  2017-11-09 CRAN (R 3.4.2)
##  digest       0.6.15  2018-01-28 CRAN (R 3.4.3)
##  dplyr      * 0.7.4   2017-09-28 CRAN (R 3.4.2)
##  evaluate     0.10.1  2017-06-24 CRAN (R 3.4.1)
##  forcats    * 0.2.0   2017-01-23 CRAN (R 3.4.0)
##  foreign      0.8-69  2017-06-22 CRAN (R 3.4.3)
##  fs         * 1.1.0   2018-01-26 CRAN (R 3.4.3)
##  ggplot2    * 2.2.1   2016-12-30 CRAN (R 3.4.0)
##  glue         1.2.0   2017-10-29 CRAN (R 3.4.2)
##  graphics   * 3.4.3   2017-12-07 local         
##  grDevices  * 3.4.3   2017-12-07 local         
##  grid         3.4.3   2017-12-07 local         
##  gtable       0.2.0   2016-02-26 CRAN (R 3.4.0)
##  haven        1.1.1   2018-01-18 CRAN (R 3.4.3)
##  hms          0.4.1   2018-01-24 CRAN (R 3.4.3)
##  htmltools    0.3.6   2017-04-28 CRAN (R 3.4.0)
##  httr         1.3.1   2017-08-20 CRAN (R 3.4.1)
##  jsonlite     1.5     2017-06-01 CRAN (R 3.4.0)
##  knitr        1.19    2018-01-29 CRAN (R 3.4.3)
##  lattice      0.20-35 2017-03-25 CRAN (R 3.4.3)
##  lazyeval     0.2.1   2017-10-29 CRAN (R 3.4.2)
##  lubridate    1.7.1   2017-11-03 CRAN (R 3.4.2)
##  magrittr     1.5     2014-11-22 CRAN (R 3.4.0)
##  memoise      1.1.0   2017-04-21 CRAN (R 3.4.0)
##  methods    * 3.4.3   2017-12-07 local         
##  mnormt       1.5-5   2016-10-15 CRAN (R 3.4.0)
##  modelr       0.1.1   2017-07-24 CRAN (R 3.4.1)
##  munsell      0.4.3   2016-02-13 CRAN (R 3.4.0)
##  nlme         3.1-131 2017-02-06 CRAN (R 3.4.3)
##  parallel     3.4.3   2017-12-07 local         
##  pillar       1.1.0   2018-01-14 CRAN (R 3.4.3)
##  pkgconfig    2.0.1   2017-03-21 CRAN (R 3.4.0)
##  plyr         1.8.4   2016-06-08 CRAN (R 3.4.0)
##  psych        1.7.8   2017-09-09 CRAN (R 3.4.3)
##  purrr      * 0.2.4   2017-10-18 CRAN (R 3.4.2)
##  R6           2.2.2   2017-06-17 CRAN (R 3.4.0)
##  Rcpp         0.12.15 2018-01-20 CRAN (R 3.4.3)
##  readr      * 1.1.1   2017-05-16 CRAN (R 3.4.0)
##  readxl       1.0.0   2017-04-18 CRAN (R 3.4.0)
##  reshape2     1.4.3   2017-12-11 CRAN (R 3.4.3)
##  rlang        0.1.6   2017-12-21 CRAN (R 3.4.3)
##  rmarkdown    1.8     2017-11-17 CRAN (R 3.4.2)
##  rprojroot    1.3-2   2018-01-03 CRAN (R 3.4.3)
##  rstudioapi   0.7     2017-09-07 CRAN (R 3.4.1)
##  rvest        0.3.2   2016-06-17 CRAN (R 3.4.0)
##  scales       0.5.0   2017-08-24 CRAN (R 3.4.1)
##  stats      * 3.4.3   2017-12-07 local         
##  stringi      1.1.6   2017-11-17 CRAN (R 3.4.2)
##  stringr    * 1.2.0   2017-02-18 CRAN (R 3.4.0)
##  tibble     * 1.4.2   2018-01-22 CRAN (R 3.4.3)
##  tidyr      * 0.8.0   2018-01-29 CRAN (R 3.4.3)
##  tidyverse  * 1.2.1   2017-11-14 CRAN (R 3.4.2)
##  tools        3.4.3   2017-12-07 local         
##  utf8         1.1.3   2018-01-03 CRAN (R 3.4.3)
##  utils      * 3.4.3   2017-12-07 local         
##  withr        2.1.1   2017-12-19 CRAN (R 3.4.3)
##  xml2         1.2.0   2018-01-24 CRAN (R 3.4.3)
##  yaml         2.1.16  2017-12-12 CRAN (R 3.4.3)
```


---
title: "01_explore-libraries_jenny.R"
author: "black"
date: "Thu Feb  1 12:28:54 2018"
---
