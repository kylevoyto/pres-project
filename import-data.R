library(readxl)
pres <- read_excel("~/OneDrive/School/Spring17/Stats/project/pres-project/2012pres.xls",
                   sheet = "Table 2. Electoral &  Pop Vote",
                   col_names = FALSE, skip = 5)
colnames(pres) <- c("State", "Electoral.Obama", "Electoral.Romney",
                    "Popular.Obama", "Popular.Romney", "Popular.Other",
                    "Popular.Total")
pres$Electoral.Obama[is.na(pres$Electoral.Obama)] <- 0
pres$Electoral.Romney[is.na(pres$Electoral.Romney)] <- 0
pres <- pres[1:51,]
save(pres, file = "~/OneDrive/School/Spring17/Stats/project/pres-project/pres.Rda")
