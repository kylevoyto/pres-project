library(readr)
census <- read_csv("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/raw-data/ACS_12_5YR_DP05_with_ann.csv")
census <- data.frame(census)
attr(census, "description") <- as.character(census[1,])
census <- census[2:nrow(census),]

census$State.Code <- substr(census$GEO.id2, 0, 2)
census <- census[!(census$State.Code %in% c("02", "09", "15",
                   "23", "25", "33", "44", "50")),]



census <- census[,c("GEO.id2", "HC01_VC03", "HC03_VC04",
                    "HC03_VC05")]
census$HC01_VC03 <- as.integer(census$HC01_VC03)
census$HC03_VC04 <- as.numeric(census$HC03_VC04)
census$HC03_VC05 <- as.numeric(census$HC03_VC05)


# Practice a merge
df <- merge(elec, census, by.x = "FIPS", by.y = "GEO.id2")
