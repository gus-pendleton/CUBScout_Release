# Using NCBI Datasets to donwload our data

datasets download genome accession --inputfile genome_accessions.txt --dehydrated --include cds

unzip ncbi_dataset.zip -d clean_genomes

datasets rehydrate --directory clean_genomes

# Find all those identically named genomes hidden deep in their folders
find ./clean_genomes -name "**.fna" > fna_files.txt

# Move them all cleanly into one folder for us to work with
i=1
while read -r line
    do 
    echo $line
    echo $i
    mv "$line" "genomes/cds_$i.fna"
    i=`expr $i + 1`
    done < fna_files.txt

# Clean up a bit
rm -r ncbi_dataset.zip

rm -r clean_genomes