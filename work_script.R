library(dplyr)
library(annotables)
# grch37

# Matrix of read counts
mtx <- read.table("counts.txt", sep="\t", header=T, as.is = T)
colnames(mtx) <- sub(".bam", "", colnames(mtx)) # Remove '.bam' suffix
# Sample annotations
annot <- read.table("E-MTAB-2319.sdrf.txt", sep="\t", header = T, as.is = T)

# Textual information about genes
mtx.txt <- mtx[, 1:6]
# Matrix of read counts
mtx.expr <- mtx[, -c(1:6)]
rownames(mtx.expr) <- mtx$Geneid

# Attach gene annotations
mtx.txt <- left_join(mtx.txt, grch37, by = c("Geneid" = "ensgene"))

# Textual information about samples
mtx.annot <- data.frame(SampleID = colnames(mtx.expr), annot[ match(colnames(mtx.expr), annot$Comment.ENA_RUN.), ])

# Three files"
# - mtx.expr - 62,069 genes x 63 samples matrix of read counts. Ensembl IDs as row names, Sample IDs as column names.
# - mtx.txt - 65,231 genes x 14 annotations. First "Geneid" column contains Ensembl IDs. Note that one EnsemblID may have multiple annotations.
# - mtx.annot - 63 samples x 37 annotations. "Characteristics: cell type" and "Characteristics: phenotype" contain information about cell types.
gz1 <- gzfile("results/mtx.expr.txt.gz", "w")
write.table(mtx.expr, gz1, sep="\t", quote = F, col.names = NA)
close(gz1)
gz1 <- gzfile("results/mtx.txt.txt.gz", "w")
write.table(mtx.txt, gz1, sep="\t", quote = F, col.names = NA)
close(gz1)
write.table(mtx.annot, "results/mtx.annot.txt", sep="\t", quote = F, col.names = NA)

