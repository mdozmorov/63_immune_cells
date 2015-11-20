# Annotation file
# wget http://ftp.ensembl.org/pub/release-70/gtf/homo_sapiens/Homo_sapiens.GRCh37.70.gtf.gz
# gzip -d Homo_sapiens.GRCh37.70.gtf.gz

REF=/var/bioinformatics-tcga-projects/mdozmorov/63_immune_cells/Homo_sapiens.GRCh37.70.gtf

DIR=/var/bioinformatics-tcga-projects/mdozmorov/63_immune_cells/02_aligned_trimmed

cd $DIR

featureCounts -p -t exon -g gene_id -a $REF -o counts.txt -T 10 ERR431566.bam ERR431573.bam ERR431580.bam ERR431587.bam ERR431594.bam ERR431601.bam ERR431608.bam ERR431615.bam ERR431622.bam ERR431567.bam ERR431574.bam ERR431581.bam ERR431588.bam ERR431595.bam ERR431602.bam ERR431609.bam ERR431616.bam ERR431623.bam ERR431568.bam ERR431575.bam ERR431582.bam ERR431589.bam ERR431596.bam ERR431603.bam ERR431610.bam ERR431617.bam ERR431624.bam ERR431569.bam ERR431576.bam ERR431583.bam ERR431590.bam ERR431597.bam ERR431604.bam ERR431611.bam ERR431618.bam ERR431625.bam ERR431570.bam ERR431577.bam ERR431584.bam ERR431591.bam ERR431598.bam ERR431605.bam ERR431612.bam ERR431619.bam ERR431626.bam ERR431571.bam ERR431578.bam ERR431585.bam ERR431592.bam ERR431599.bam ERR431606.bam ERR431613.bam ERR431620.bam ERR431627.bam ERR431572.bam ERR431579.bam ERR431586.bam ERR431593.bam ERR431600.bam ERR431607.bam ERR431614.bam ERR431621.bam ERR431628.bam

cd ..

