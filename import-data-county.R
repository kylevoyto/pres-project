library(readr)
df <- read_csv("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/raw-data/US presidential election results by county.csv")
df <- data.frame(df)

# Get the Obama.Votes column
obama <- ifelse(df[,"Last.name"] == "Obama" &
                  !is.na(df[,"Last.name"]),
                df[,"Votes"], 0)
additions <- sum(df[,"Last.name"] == "Obama" &
                   !is.na(df[,"Last.name"]))
current <- additions
total <- nrow(df)
cat(paste0("Added: ", additions))
cat(paste0("Total: ", current, "/", total))
for (i in 1:15) {
  obama <- obama + ifelse(df[,paste0("Last.name_", i)] == "Obama" &
                            !is.na(df[,paste0("Last.name_", i)]),
                          df[,paste0("Votes_", i)],
                          rep(0, total))
  additions <- sum(df[,paste0("Last.name_", i)] == "Obama" &
                     !is.na(df[,paste0("Last.name_", i)]))
  current <- current + additions
  cat(paste0("Added: ", additions, "\n"))
  cat(paste0("Total: ", current, "/", total, "\n"))
}

# Get the Romney.Votes column
romny <- ifelse(df[,"Last.name"] == "Romney" &
                  !is.na(df[,"Last.name"]),
                df[,"Votes"], 0)
additions <- sum(df[,"Last.name"] == "Romney" &
                   !is.na(df[,"Last.name"]))
current <- additions
total <- nrow(df)
cat(paste0("Added: ", additions))
cat(paste0("Total: ", current, "/", total))
for (i in 1:15) {
  romny <- romny + ifelse(df[,paste0("Last.name_", i)] == "Romney" &
                            !is.na(df[,paste0("Last.name_", i)]),
                          df[,paste0("Votes_", i)],
                          rep(0, total))
  additions <- sum(df[,paste0("Last.name_", i)] == "Romney" &
                     !is.na(df[,paste0("Last.name_", i)]))
  current <- current + additions
  cat(paste0("Added: ", additions, "\n"))
  cat(paste0("Total: ", current, "/", total, "\n"))
}

# Get the Other.Votes column
other <- ifelse(df[,"Last.name"] != "Romney" &
                  df[,"Last.name"] != "Obama" &
                  !is.na(df[,"Last.name"]),
                df[,"Votes"], 0)
additions <- sum(df[,"Last.name"] != "Romney" &
                   df[,"Last.name"] != "Obama" &
                   !is.na(df[,"Last.name"]))
current <- additions
total <- nrow(df)
cat(paste0("Added: ", additions))
cat(paste0("Total: ", current, "/", total))
for (i in 1:15) {
  other <- other + ifelse(df[,paste0("Last.name_", i)] != "Romney" &
                            df[,paste0("Last.name_", i)] != "Obama" &
                            !is.na(df[,paste0("Last.name_", i)]),
                          df[,paste0("Votes_", i)],
                          rep(0, total))
  additions <- sum(df[,paste0("Last.name_", i)] != "Romney" &
                     df[,paste0("Last.name_", i)] != "Obama" &
                     !is.na(df[,paste0("Last.name_", i)]))
  current <- current + additions
  cat(paste0("Added: ", additions, "\n"))
  cat(paste0("Total: ", current, "/", total, "\n"))
}

# Put together final dataset
elec <- df[,c(3, 4, 1, 5, 8, 9, 11)]
colnames(elec) <- c("County.Number", "FIPS", "State", "County",
                    "Reporting.Precintcs", "Total.Precincts",
                    "Total.Votes")
elec$Total.Votes <- elec$Total.Votes
elec$Obama.Votes <- as.integer(obama)
elec$Romney.Votes <- as.integer(romny)
elec$Other.Votes <- as.integer(other)

# Save final dataset
save(elec, file = "C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/data/elec.Rda")


