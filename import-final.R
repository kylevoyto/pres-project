# import data
load("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/data/elec.Rda")
load("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/data/census.Rda")

# merge the datasets
df <- merge(elec, census, by.x = "FIPS", by.y = "GEO.id2")

# save final dataset
save(df, file = "C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/data/df.Rda")


