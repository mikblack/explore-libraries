#' Which libraries does R search for packages?
.Library
.libPaths()

#' Installed packages

## use installed.packages() to get all installed packages
installed.packages()
dim(installed.packages())
class(installed.packages())

## how many packages?
instPack <- installed.packages()
nrow(instPack)
## 463

head(instPack)

#' Exploring the packages

View(head(instPack))

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both

table(instPack[,"License"], instPack[,"Built"])

## sort packages by number of dependencies:
tail(sort(unlist(lapply(strsplit(instPack[,"Imports"],","), length))))

## sort packages by number of times they are a dependency:
tail(sort(table(unlist(strsplit(instPack[,"Imports"],",")))))

##   * what proportion need compilation?
table(instPack[,"NeedsCompilation"])
## 209/(231+209) = 0.475

##   * how break down re: version of R they were built on
table(instPack[,"Built"])
## 3.3.2 3.4.0 3.4.1 3.4.2 3.4.3 
##     6   165    39   106   147 

#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?

table(instPack[,"Priority"], useNA='always')
## base recommended        <NA> 
##   14          15         434 

##   * how does the result of .libPaths() relate to the result of .Library?
.Library
.libPaths()
## I only have one place where packages live:
## /Library/Frameworks/R.framework/Versions/3.4/Resources/library

#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
## No!  :)

## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!

instPackURL <- installed.packages(fields="URL")
View(head(instPackURL))
sum(is.na(instPackURL[,"URL"]))
## 198
