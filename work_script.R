library(dplyr)
library(annotables)
options(stringsAsFactors = FALSE)
# grch37

# Matrix of read counts
mtx <- read.table("data/counts.txt.gz", sep="\t", header=T, as.is = T)
colnames(mtx) <- sub(".bam", "", colnames(mtx)) # Remove '.bam' suffix
# Sample annotations
annot <- read.table("data/E-MTAB-2319.sdrf.txt", sep="\t", header = T, as.is = T)

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

## Explore Treg signature
mtx.expr <- limma::normalizeQuantiles(log2(mtx.expr + 1))
mtx.annot_selected <- mtx.annot$SampleID[ grep("Treg", mtx.annot$Characteristics.cell.type., ignore.case = TRUE)]
mtx.expr_selected  <- mtx.expr[, colnames(mtx.expr) %in% mtx.annot_selected]
boxplot(mtx.expr_selected)
# Exclude one sample
mtx.annot_selected <- mtx.annot_selected[ mtx.annot_selected != "ERR431589"]
mtx.expr_selected  <- mtx.expr_selected[, colnames(mtx.expr_selected) != "ERR431589"]
all.equal(mtx.annot_selected, colnames(mtx.expr_selected))
# Summarize Treg signature by median across samples
signature_Treg <- apply(mtx.expr_selected, 1, mean)
signature_Treg <- signature_Treg[ signature_Treg > 0]

library(biomaRt)
mart <- useMart("ensembl", dataset="hsapiens_gene_ensembl")
genes<-getBM(attributes=c('ensembl_gene_id','hgnc_symbol','description'), filters='ensembl_gene_id', values=names(signature_Treg), mart=mart, uniqueRows=T)

dim(genes)
length(signature_Treg)
length(setdiff(names(signature_Treg), genes$ensembl_gene_id))

signature_Treg_mtx <- left_join(data.frame(ensembl_gene_id = names(signature_Treg),
                                           expression      = signature_Treg), genes)
signature_Treg_mtx <- signature_Treg_mtx[signature_Treg_mtx$hgnc_symbol != "", ]
signature_Treg_mtx <- signature_Treg_mtx[order(signature_Treg_mtx$expression, decreasing = T), ]

which(signature_Treg_mtx$hgnc_symbol == "FOXP3")
writeLines(signature_Treg_mtx$hgnc_symbol[1:500], "results/Treg_500.txt")
