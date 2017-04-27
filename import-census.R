library(readr)

### First census dataset

# import dataset
census <- read_csv("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/raw-data/ACS_12_5YR_DP05_with_ann.csv")
census <- data.frame(census)
census <- census[2:nrow(census),]

# select rows
census$State.Code <- substr(census$GEO.id2, 0, 2)
census <- census[!(census$State.Code %in% c("02", "09", "15",
                   "23", "25", "33", "44", "50")),]

# select columns
census <- census[,c("GEO.id2", "HC01_VC03", "HC03_VC04",
                    "HC03_VC05", "HC03_VC07", "HC03_VC08",
                    "HC03_VC09", "HC03_VC10", "HC03_VC11",
                    "HC03_VC12", "HC03_VC13", "HC03_VC14",
                    "HC03_VC15", "HC03_VC16", "HC03_VC17",
                    "HC03_VC18", "HC03_VC19", "HC01_VC23",
                    "HC03_VC82", "HC03_VC88", "HC03_VC89",
                    "HC03_VC90", "HC03_VC91", "HC03_VC92",
                    "HC03_VC93", "HC03_VC94", "HC03_VC95",
                    "HC03_VC96")]

census$HC01_VC03 <- as.integer(census$HC01_VC03)
census$HC03_VC04 <- as.numeric(census$HC03_VC04)
census$HC03_VC05 <- as.numeric(census$HC03_VC05)

census$HC03_VC07 <- as.numeric(census$HC03_VC07)
census$HC03_VC08 <- as.numeric(census$HC03_VC08)
census$HC03_VC09 <- as.numeric(census$HC03_VC09)
census$HC03_VC10 <- as.numeric(census$HC03_VC10)
census$HC03_VC11 <- as.numeric(census$HC03_VC11)
census$HC03_VC12 <- as.numeric(census$HC03_VC12)
census$HC03_VC13 <- as.numeric(census$HC03_VC13)
census$HC03_VC14 <- as.numeric(census$HC03_VC14)
census$HC03_VC15 <- as.numeric(census$HC03_VC15)
census$HC03_VC16 <- as.numeric(census$HC03_VC16)
census$HC03_VC17 <- as.numeric(census$HC03_VC17)
census$HC03_VC18 <- as.numeric(census$HC03_VC18)
census$HC03_VC19 <- as.numeric(census$HC03_VC19)

census$HC01_VC23 <- as.integer(census$HC01_VC23)

census$HC03_VC82 <- as.numeric(census$HC03_VC82)
census$HC03_VC88 <- as.numeric(census$HC03_VC88)
census$HC03_VC89 <- as.numeric(census$HC03_VC89)
census$HC03_VC90 <- as.numeric(census$HC03_VC90)
census$HC03_VC91 <- as.numeric(census$HC03_VC91)
census$HC03_VC92 <- as.numeric(census$HC03_VC92)
census$HC03_VC93 <- as.numeric(census$HC03_VC93)
census$HC03_VC94 <- as.numeric(census$HC03_VC94)
census$HC03_VC95 <- as.numeric(census$HC03_VC95)
census$HC03_VC96 <- as.numeric(census$HC03_VC96)

colnames(census)[2] <- "Total.Population"
colnames(census)[3] <- "Male"
colnames(census)[4] <- "Female"
colnames(census)[18] <- "Voting.Population"

census$Age.19under <- census$HC03_VC07 + census$HC03_VC08 +
  census$HC03_VC09 + census$HC03_VC10
census$Age.20to34 <- census$HC03_VC11 + census$HC03_VC12
census$Age.35to54 <- census$HC03_VC13 + census$HC03_VC14
census$Age.55over <- census$HC03_VC15 + census$HC03_VC16 +
  census$HC03_VC17 + census$HC03_VC18 + census$HC03_VC19

census$HC03_VC07 <- NULL
census$HC03_VC08 <- NULL
census$HC03_VC09 <- NULL
census$HC03_VC10 <- NULL
census$HC03_VC11 <- NULL
census$HC03_VC12 <- NULL
census$HC03_VC13 <- NULL
census$HC03_VC14 <- NULL
census$HC03_VC15 <- NULL
census$HC03_VC16 <- NULL
census$HC03_VC17 <- NULL
census$HC03_VC18 <- NULL
census$HC03_VC19 <- NULL

colnames(census)[6] <- "Hispanic"
colnames(census)[7] <- "White"
colnames(census)[8] <- "Black"
colnames(census)[9] <- "Native"
colnames(census)[10] <- "Asian"
census$Other <- census$HC03_VC92 + census$HC03_VC93 +
  census$HC03_VC94 + census$HC03_VC95 + census$HC03_VC96

census$HC03_VC92 <- NULL
census$HC03_VC93 <- NULL
census$HC03_VC94 <- NULL
census$HC03_VC95 <- NULL
census$HC03_VC96 <- NULL

census <- census[,c(1, 2, 5, 3, 4, 11, 12, 13, 14, 6, 7,
                    8, 9, 10, 15)]

### Second census dataset

# import dataset
census2 <- read_csv("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/raw-data/ACS_12_5YR_DP04_with_ann.csv")
census2 <- data.frame(census2)
census2 <- census2[2:nrow(census2),]

# select rows
census2$State.Code <- substr(census2$GEO.id2, 0, 2)
census2 <- census2[!(census2$State.Code %in% c("02", "09", "15",
                     "23", "25", "33", "44", "50")),]

# select columns
census2 <- census2[,c("GEO.id2", "HC03_VC82")]
census2$HC03_VC82 <- as.numeric(census2$HC03_VC82)
colnames(census2)[2] <- "No.Vehicles"

### Third census dataset

# import dataset
census3 <- read_csv("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/raw-data/ACS_12_5YR_DP03_with_ann.csv")
census3 <- data.frame(census3)
census3 <- census3[2:nrow(census3),]

# select rows
census3$State.Code <- substr(census3$GEO.id2, 0, 2)
census3 <- census3[!(census3$State.Code %in% c("02", "09", "15",
                     "23", "25", "33", "44", "50")),]

# select columns
census3 <- census3[,c("GEO.id2", "HC03_VC156")]
census3$HC03_VC156 <- as.numeric(census3$HC03_VC156)
colnames(census3)[2] <- "Poverty"

### Fourth census dataset

# import dataset
census4 <- read_csv("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/raw-data/ACS_12_5YR_DP02_with_ann.csv")
census4 <- data.frame(census4)
census4 <- census4[2:nrow(census4),]

# select rows
census4$State.Code <- substr(census4$GEO.id2, 0, 2)
census4 <- census4[!(census4$State.Code %in% c("02", "09", "15",
                     "23", "25", "33", "44", "50")),]

# select columns
census4 <- census4[,c("GEO.id2", "HC03_VC94")]
census4$HC03_VC94 <- as.numeric(census4$HC03_VC94)
colnames(census4)[2] <- "College"

### Merge datasets

census <- merge(census, census2, by = "GEO.id2")
census <- merge(census, census3, by = "GEO.id2")
census <- merge(census, census4, by = "GEO.id2")

# Save final dataset
save(census, file = "C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/data/census.Rda")


