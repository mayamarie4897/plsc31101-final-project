#Plotting the data 

require(ggplot2)

#Adding state abbreviation column to merged data frame 
state_merge$ID <- c("AZ", "CA", "CO", "FL", "GA", "IL", "IN", "KY", "LA", "MA", 
                    "MO", "NV", "NJ", "NM", "NY", "NC", "OH", "OR", "PA", "TN", "TX", 
                    "VA", "WA", "WI")
state_merge$state <- NULL

#Plotting both data set frequencies
sum_df <- state_merge %>%
  group_by(ID) %>%
  summarise_all(sum)

tidy_df <- sum_df %>%
  gather(vice, tevus, -ID)

ggplot(tidy_df, aes(x = reorder(ID, tevus), fill = vice, y = tevus))+
  geom_col(position = position_dodge(width = 0.2), width = 0.6) +
  scale_fill_discrete(name = "Dataset", labels = c("Right Wing", "Police")) +
  ggtitle("Police Use of Force and Right Wing Extremist Violence") +
  xlab("State") + ylab("Frequency") +
  theme(axis.text.x=element_text(angle=50, size=7.5, vjust=0.5))

#Regression model and table

#City regression 
mod_1 <- lm(data = city_merge, vice ~ tevus)

stargazer(mod_1, title = "Regression Results for Cities", type = "text", covariate.labels = "TEVUS: Right Wing", omit = "Constant", dep.var.labels = "DV: VICE Police Use of Force", keep.stat = "n", style = "ajps", out = "regression-table.txt")

#State regression
require(stargazer)

mod_2 <- lm(data = state_merge, vice ~ tevus)

stargazer(mod_2, title = "Regression Results for States", type = "text", 
          covariate.labels = "TEVUS: Right Wing", omit = "Constant", 
          dep.var.labels = "DV: VICE Police Use of Force", keep.stat = "n", 
          style = "ajps", out = "regression-table.txt")
