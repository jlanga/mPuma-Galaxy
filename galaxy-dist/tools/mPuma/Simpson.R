
# R script for performing Simpson test on a biom file
# Only argument is path to biom file, eg Rscript Simpson.R /home/mikel/UPM/mPUMA-Galaxy/biom/biom-format-1.2.0/examples/min_dense_otu_table.biom

args<-commandArgs(TRUE)

suppressMessages(library(vegan))

suppressMessages(library(biom))

biom_file <- args[1]

x1 = read_biom(biom_file)

H <- diversity((as(biom_data(x1), "matrix")), index = "simpson")

H