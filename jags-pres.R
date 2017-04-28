# Final Project R Code
# 2012 Presidential Election
# Course: Stat 3303
# By: Kyle Voytovich

library(rjags)
library(ggplot2)
library(reshape2)

set.seed(89879841)



# -------------
# Data set-up
# -------------

# read in the student data
load("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/data/df.Rda")

# response
# - % of people who voted for Obama amongst people who
#   either voted for Obama or Romney
df$Y <- df$Obama.Votes / (df$Obama.Votes + df$Romney.Votes)

# modifications to the data
df$State <- as.factor(df$State)
state.code <- levels(df$State)
state.name <- c("Alaska", "Arkansas", "Arizona", "California", "Colorado",
                "District of Columbia", "Delaware", "Florida", "Georgia",
                "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", "Kentucky",
                "Louisiana", "Maryland", "Michigan", "Minnesota",
                "Missouri", "Mississippi", "Montana", "North Carolina", "North Dakota",
                "Nebraska", "New Jersey", "New Mexico", "Nevada",
                "New York", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
                "South Carolina", "South Dakota", "Tennessee", "Texas",
                "Utah", "Virginia", "Washington", "Wisconsin",
                "West Virginia", "Wyoming")
df$l.Total.Population <- log(df$Total.Population)

# data to be used in model
Y <- df$Y
State <- df$State
l.Total.Population <- df$l.Total.Population
White <- df$White
College <- df$College
Female <- df$Female
Poverty <- df$Poverty
No.Vehicles <- df$No.Vehicles
n.counties <- nrow(df)
n.states <- length(unique(df$State))
p.counties <- 7



# -------------
# JAGS Set-up
# -------------

# model data in list format
model.data <- list("Y" = Y,
                   "State" = State,
                   "Female" = Female,
                   "l.Total.Population" = l.Total.Population,
                   "White" = White,
                   "College" = College,
                   "Poverty" = Poverty,
                   "No.Vehicles" = No.Vehicles,
                   "n.counties" = n.counties,
                   "n.states" = n.states,
                   "p.counties" = p.counties)

# parameters in the model
model.params <- c("beta",
                  "tau2",
                  "alpha",
                  "tau2_alpha")

# initial values
init.params <- list("beta" = rep(0, p.counties),
                    "tau2" = .1,
                    "alpha" = rep(0, n.states),
                    "tau2_alpha" = .1)

# number of iterations for each step
tune.steps <- 5000
burn.steps <- 5000
save.steps <- 25000
thin.steps <- 1

# number of chains
n.chains <- 2              

# iterations per chain
ITER <- ceiling(save.steps / n.chains) 



# -------------
# Run JAGS
# -------------

# create, initialize, and adapt the model
model <- jags.model("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/pres-model.txt", 
                    data = model.data, 
                    inits = init.params, 
                    n.chains = n.chains, 
                    n.adapt = tune.steps)

# burn-in the algorithm
update(model, n.iter = burn.steps)

# run algorithm to get interations for inference
coda <- coda.samples(model, 
                     variable.names = model.params, 
                     n.iter = ITER, 
                     thin = thin.steps)



# -------------
# Look at posterior samples
# -------------

# posterior samples
samples <- data.frame(as.matrix(coda, iters = T, chains = T))
samples$CHAIN <- as.factor(samples$CHAIN)
samples$sigma2 <- 1/samples$tau2
samples$tau2 <- NULL
samples$sigma2_alpha <- 1/samples$tau2_alpha
samples$tau2_alpha <- NULL

# trace plots

parameters <- colnames(samples)[3:ncol(samples)]
for (i in 1:length(parameters)) {
  g <- ggplot(samples, aes_string(x = "ITER", y = parameters[i])) +
    geom_line(aes_string(color = "CHAIN")) +
    labs(y = parameters[i]) +
    ggtitle(paste("Trace plot for", parameters[i]))
  ggsave(paste0("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/",
                "trace-plots/", parameters[i], "trace.png"),
         plot = g, device = "png",
         width = 4, height = 2, units = "in")
}

# alpha and beta lookup
alpha <- colnames(samples)[3:45]
beta <- colnames(samples)[46:(46+p.counties-1)]

# posterior distributions

samples.flat <- melt(samples, 
                     id.vars = "ITER",
                     measure.vars = alpha)
ggplot(samples.flat, aes(x = variable, y = value )) +
  geom_boxplot() +
  scale_x_discrete(labels = state.code) +
  ggtitle("Effect of States on Election Outcome") +
  ylab("Posterior") +
  xlab("alpha by State") 

ggplot(samples, aes_string(x = "sigma2")) +
  geom_histogram(bins = 25) +
  ggtitle(paste("Effect of", "sigma2")) +
  xlab(paste0("sigma2")) +
  ylab("Samples") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(samples, aes_string(x = "sigma2_alpha")) +
  geom_histogram(bins = 25) +
  ggtitle(paste("Effect of", "sigma2_alpha")) +
  xlab(paste0("sigma2_alpha")) +
  ylab("Samples") +
  theme(plot.title = element_text(hjust = 0.5))

beta.names <- c("Intercept", "Female", "Log Total Population",
                "White", "College", "Poverty", "No Vehicles")
for (beta.no in 2:p.counties) {
  g <- ggplot(samples, aes_string(x = beta[beta.no])) +
    geom_histogram(bins = 25) +
    ggtitle(paste("Effect of", beta.names[beta.no])) +
    xlab(paste0("beta[", beta.no, "]")) +
    ylab("Samples") +
    theme(plot.title = element_text(hjust = 0.5))
  ggsave(paste0("C:/Users/kylev/OneDrive/School/Spring17/Stats/project/pres-project/",
                "param-plots/", beta[beta.no], "trace.png"),
         plot = g, device = "png")
}
