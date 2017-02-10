# Normalize data using Median-Ratio Normalization


The original description of this method is from Anders and Huber, 2010. The implementation here is borrowed from the EBSeq R package.

Input data must be a matrix of unnormalized expression in .txt or .csv format. 

This method estimates scale factors for each sample using stably expressed genes (genes with no zeros). For each sample,
the scale factor is equal to the median of each gene's ratio to it's geometric mean. The geometric mean for each gene is calculated over all samples.

This can be used to effectively normalized bulk RNA-seq data. For single cell RNA-seq data see: <a href="https://github.com/rhondabacher/SCnorm">SCnorm</a>


## 1. Installation
To run, it requires the following packages: shiny

> install.packages("shiny")
> install.packages("shinyFiles")


### Run the app
To launch the app, in R run:
> library(shiny)
> library(shinyFiles)
> runGitHub('rhondabacher/Median-Ratio-Normalization')

<!-- ![Screenshot](https://github.com/rhondabacher/Oscillating-genes/blob/master/screenshot.png) -->
