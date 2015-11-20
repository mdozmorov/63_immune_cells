# Gene expression profiles of 63 immune cell types

Bonnal RJP, Ranzani V, Arrigoni A, Curti S, Panzeri I, Gruarin P, Abrignani S, Rossetti G, Pagani M: [De novo transcriptome profiling of highly purified human lymphocytes primary cells](http://www.ncbi.nlm.nih.gov/pubmed/26451251). Sci Data 2015, 2:150051.

[Data source](https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-2319/samples/?s_page=1&s_pagesize=250)

Briefly, FASTQ files were downloaded, trimmed with _Trimmomatic_, aligned with [_subread_](http://subread.sourceforge.net/) to hg19, summarized using _featureCount_ to _Homo_sapiens.GRCh37.70.gtf_. 

Counts are in "data/counts.txt"

### Annotated results are in the "results" folder

- `mtx.expr.txt.gz` - 62,069 genes x 63 samples matrix of read counts. Ensembl IDs as row names, Sample IDs as column names.

- `mtx.txt.txt.gz` - 65,231 genes x 14 annotations. First "Geneid" column contains Ensembl IDs. Note that one EnsemblID may have multiple annotations.

- `mtx.annot.txt` - 63 samples x 37 annotations. "Characteristics: cell type" and "Characteristics: phenotype" contain information about cell types.
