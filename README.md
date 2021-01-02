# Getting and Cleaning Data Course Project

This repository contains four files in total:

- The R script run_analysis.R, which contains code to perform cleaning and analysis on the data set
- The code book Codebook.md, which contains information about variable names and summaries calculated in run_analysis.R
- The tidy data set tidy_data.txt, as described in the project page
- This README.me file

The script downloads and then unzips the file in the current working directory. To run the script, download run_analysis.R, and load it using RStudio or any compatible R IDE. The libraries `dplyr`, `readr`, `stringr`, and `plyr` have been used in the file. The installation commands are commented just before requiring the libraries. If you do not already have these libraries installed, uncomment the line above appropriate require to install them. 