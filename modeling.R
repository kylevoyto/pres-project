# import data
load("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/data/df.Rda")

# response
# - % of people who voted for Obama amongst people who
#   either voted for Obama or Romney

df$y <- df$Obama.Votes / (df$Obama.Votes + df$Romney.Votes)



