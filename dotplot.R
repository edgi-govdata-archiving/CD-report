#Making the dot plot

#comparing violations
#let's combine the violations data at national, state, CD level
names(USAviolationsper1000_All)[2] <- "violationsper1000"
USAviolationsper1000_All$Region <- as.factor("National")
names(`violationsper1000_All_pg4_VA-090820.csv`)[2] <- "violationsper1000"
`violationsper1000_All_pg4_VA-090820.csv`$Region <- as.factor("State")
names(`violationsper1000_All_pg4_VA-4`)[2] <- "violationsper1000"
`violationsper1000_All_pg4_VA-4`$Region <- as.factor("Congressional District")
violationsper1000 <- rbind(USAviolationsper1000_All, `violationsper1000_All_pg4_VA-090820.csv`, `violationsper1000_All_pg4_VA-4`)
violationsper1000$violationsper1000 <- as.numeric(violationsper1000$violationsper1000)
violationsper1000[2] <-round(violationsper1000[2],0)


##let's make a for loop to call in all of the data #each time this section is run, change "here" to specify the subfolder for the district or state
#Also, the way it is set up, you're going to need to cntrl f to change the district and date for the files
filenames = list.files(here("violationsper1000"), pattern = ".csv")
file_count = length(filenames)
for (i in filenames){
  name <- gsub("^([^_]*_[^_]*_[^_]*_[^-]*-[^-]*)-.*$","\\1", i)
  assign(name, read.csv(here("violationsper1000", i)))
  filenames$District <- (name)
}





