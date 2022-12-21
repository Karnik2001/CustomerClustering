library(stats)   # statistical functions and calculations
library(ggplot2) # plotting graphs 
library(plyr)    # data manipulation
library(dplyr)   # data manipulation
library(data.table)   # high performance of data frames
library(corrplot)     # correlation matrix to detect hidden patterns among variables 
library(RColorBrewer) # colorful graphs from different palettes
library(factoextra)   # extract and visualize the multivariate data analyses
library(NbClust)      # determine the optimal number of clusters and clustering schemes 
library (cluster)     # methods for cluster analysis
library("fpc")        # Different methods of clustering and cluster validation


# load the dataset
mall <- read.csv("C:\\Users\\visha\\Downloads\\Mall_Customers.csv")

# remove the categorical variables
malldf <- mall[c(-2)]

# rename the spending score and annual income columns
malldf <- malldf %>%
  rename_at('Annual.Income..k..', ~ 'Annual Income')
malldf <- malldf%>%
  rename_at('Spending.Score..1.100.', ~'Spending Score')

# reproducible code
set.seed(42)
# split the dataset into a test and train data by 6:4 ratio
malldf <- sample_frac(mall,0.6)
mall.index <- as.numeric(rownames(malldf))
mall.test <- mall[-mall.index,]
head(malldf)
View(malldf)

# determine the data type in the data frame
str(malldf)

# summary of the dataset
summary(malldf)

# check for any null values
summary(is.na(malldf))

# frequency of the numeric variables
table(malldf$Age)
table(malldf$`Annual Income`)
table(malldf$`Spending Score`)

# calculate the mean of the spending score
malldf %>%
  group_by()%>%
  summarise(mean_spend = mean(malldf$`Spending Score`))

# calculate the mean of the annual income
malldf%>%
  group_by()%>%
  summarise(mean_income = mean(malldf$`Annual Income`))

# store the dataset into a variable for correlation
Mall <- cor(malldf)
col <- colorRampPalette(c("red", "lightblue", 
                          "black", "green",
                          "brown"))

# correlation of the dataset
corrplot(Mall, method = "number", col = col(50)) + title(main = "Correlation of Customer Information ")

# check for any outliers in the dataset
apply(X= malldf,MARGIN=2, FUN = function(x)length(boxplot.stats(x)$out))

# sort the values of the annual income column
sort(boxplot.stats(malldf$`Annual Income`)$out)

# examine the 90 and 95 percentile of the annual income column
quantile(malldf$`Annual Income`, probs = seq(from =0.9, to=1, by=0.025))
mall.max <- as.numeric(quantile(malldf$`Annual Income`, prob = 0.95))
mall.max <- malldf$`Annual Income`[malldf$`Annual Income` > mall.max]
mall.max

# plot the annual income vs the spending score 
ggplot(data = malldf, aes(x = `Annual Income`, y = `Spending Score`)) + geom_point(shape = 1) + geom_smooth(method = "lm")

# plot the age vs the spending score
ggplot(data = malldf, aes(x = Age, y = `Spending Score`)) + geom_point(shape = 1) + geom_smooth(method = "lm")

# plot the age vs the annual income 
ggplot(data = malldf, aes(x = Age, y = `Annual Income`))+ geom_point(shape = 1) + geom_smooth(method = "lm")

# create a subset to run k means
mall.subset1 <- as.data.frame(malldf[,c("Age","Annual Income","")])
summary(mall.subset1)

mall.subset2 <- as.data.frame(malldf[,c("Annual Income","Spending Score")])
summary(mall.subset2)

# normalize the subset
mall.subset1 <- as.data.frame(scale(mall.subset1))
summary(mall.subset1)

mall.subset2 <- as.data.frame(scale(mall.subset2))
summary(mall.subset2)

# create a plot of the elbow method
set.seed(102)
fviz_nbclust(mall.subset1, kmeans, method = "wss") + labs(subtitle = "Elbow method")

set.seed(102)
fviz_nbclust(mall.subset2, kmeans, method = "wss") + labs(subtitle = "Elbow method")

# create a plot of the silhouette method
fviz_nbclust(mall.subset1, kmeans, method = "silhouette")+ labs(subtitle = "Silhouette method")
fviz_nbclust(mall.subset2,kmeans, method = "silhouette")+ labs(subtitle = "Silhouette method")

# create a plot of the gap statistics method
set.seed(123)
fviz_nbclust(mall.subset1, kmeans, nstart = 25, method = "gap_stat", nboot = 50) + labs(subtitle = "Gap Statistic Method")
fviz_nbclust(mall.subset2, kmeans, nstart = 25, method = "gap_stat", nboot = 50) + labs(subtitle = "Gap Statistic Method")


# create a kmeans dataset to determine the number of clusters in each column
set.seed(145)
kmean.simple <- kmeans(mall.subset1, centers=2, iter.max = 30, nstart = 100)
mall.subset1$cluster <- factor(kmean.simple$cluster)
summary(mall.subset1)

kmean.simple1 <- kmeans(mall.subset2, centers=2, iter.max = 30, nstart = 100)
mall.subset2$cluster <- factor(kmean.simple$cluster)
summary(mall.subset2)

# create centroids of the kmeans subsets
ggplot(data=mall.subset1, aes(x=Age, y=`Annual Income`, colour=cluster))+geom_point()+geom_point(data=as.data.frame(kmean.simple$centers), 
color ="black", size=4, shape =17)

ggplot(data=mall.subset2, aes(x=`Annual Income`, y= `Spending Score`, colour=cluster))+geom_point()+geom_point(data=as.data.frame(kmean.simple1$centers), 
color ="black", size=4, shape =17)

# plot the internal cluster validation of the kmeans subset
C <- daisy(mall.subset1)
plot(silhouette(kmean.simple$cluster, C), col=1:2, border = NA)

D <- daisy(mall.subset2)
plot(silhouette(kmean.simple1$cluster, D), col = 3:4, border = NA)

# calculate the cluster stats
set.seed(125)
species <- as.numeric(kmean.simple$cluster)
stats <- cluster.stats(d = dist(malldf), species, kmean.simple$cluster)

species <- as.numeric(kmean.simple1$cluster)
stats1 <- cluster.stats(d = dist(malldf), species, kmean.simple$cluster)


# calculate the corrected Rand index
stats$corrected.rand
stats1$corrected.rand

# calculate the Meila's variation index 
stats$vi
stats1$vi

# calculate the betweenss of the cluster distance between clusters
set.seed(125)
kmean.simple
kmean.simple$betweenss
kmean.simple1$betweenss

