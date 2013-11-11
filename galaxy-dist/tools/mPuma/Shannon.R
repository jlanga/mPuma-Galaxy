

# R script for performing Shannon test on a biom file
# Only argument is path to biom file, eg Rscript Shannon.R /home/mikel/UPM/mPUMA-Galaxy/biom/biom-format-1.2.0/examples/min_dense_otu_table.biom

args<-commandArgs(TRUE)

# I learned how to supress R messages at http://stackoverflow.com/questions/11855072/using-rscript-is-there-a-decent-way-to-suppress-the-non-script-output

# library(vegan)
suppressMessages(library(vegan))

# library(biom)
suppressMessages(library(biom))

# min_dense_file <- "/home/mikel/UPM/mPUMA-Galaxy/biom/biom-format-1.2.0/examples/min_dense_otu_table.biom"
biom_file <- args[1]
x1 = read_biom(biom_file)
# H <- diversity(as(biom_data(x1), "matrix"))
H <- diversity((as(biom_data(x1), "matrix")), index = "shannon")
H