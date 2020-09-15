#just trying to pull some data together to test stats


write.csv(CWAviolations, here("toteststats/VA4_CWAviolations.csv"))
write.csv(CWAenforcement, here("toteststats/VA4_CWAenforcement.csv"))
write.csv(enforcement, here("toteststats/VA4_allenforcement.csv"))



filenames = list.files(here("toteststats"), pattern = ".csv")
file_count = length(filenames)
for (i in filenames){
  name <- gsub("^([^_]*_[^_]*)$","\\1", i)
  assign(name, read.csv(here("toteststats", i)))
}


VA4_allenforcement.csv$CD <- as.character("VA4")
VA4_allenforcement.csv <- VA4_allenforcement.csv %>%
  select(CD,Date,Amount,Count,Amountinthousands, President)


allenforcement <- rbind(CA36_allenforcement.csv, FL14_allenforcement.csv, OR2_allenforcement.csv, TX26_allenforcement.csv,
                       VA4_allenforcement.csv)


write.csv(allenforcement, here("toteststats/allenforcement_5CDs.csv"))



