# Cluster of Customer Mall Credit

The purpose of this project is to analyze data using a technique called clustering to find subsets that have similarity. Clustering is a technique used in the data science field to segment data into several groups of similarity. Applications of clustering would be marketing, medical science, games, and the internet.

Steps to implement clustering in R

1. Import the libraries and load the dataset
2. Remove any unnecessary columns and rename columns that have long characters
3. Split the dataset into a training and test dataset
4. Determine the data types in the dataset.
5. Summary of the dataset plus checking for any null values.
6. Calculate the mean of the spending score and the annual income.
7. Correlation of the dataset.
8. Check and remove any outliers.
9. Plot all of three numeric variables to find relationships.
10. Create subsets to run kmeans.
11. Normalize the subsets.
12. Create plots of the elbow method.
13. Create plots of the silhouette method.
14. Create plots of the gap statistics method.
15. Create kmeans subsets to determine the number of clusters.
16. Create centroids of the kmeans subsets.
17. Create internal cluster validation plots of the kmeans subsets.
18. Calculate the cluster stats
19. Calculate the Meila's variation index
20. Calculate the betweenss of the cluster distance between clusters.



Conclusion: The age and annual income cluster has 44 and 76 observations equivalent to the 40% to 60 % ratio. Cluster 1 annual income is higher than cluster 2 based on the centriod mean.  The intra cluster bond strength of cluster 1 is 35.15666 and cluster 2 is 110.20722. The goodness of the classification k-means is 38.9 % (low fit). The between clusters is 92.63612. 

The age and spending score has 62 and 58 observations equivalent to the 40% to 60% ratio. Cluster 1 spending score is higher than cluster 2 based on the centriod mean. The intra cluster bond strength of cluster 1 is 67.43173 and cluster 2 is 40.01625. The goodness of the classification k-means is 54.9 % (average fit). The between clusters is 130.552. 

The annual income and spending score cluster has 41 and 79 observations equivalent to the 40 % to 60 %. Cluster 1 annual income is higher than cluster 2 based on the centriod mean. The intra cluster bond strength of cluster 1 is 63.31879 and cluster 2 is 94.66942. The goodness of the classification k-means is 33.6 % (low fit).The between clusters is 80.01179. 
