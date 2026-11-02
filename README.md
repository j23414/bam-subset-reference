# bam-subset-reference

A modular workflow for filtering the alignment file to a subset of references prior to downstream analysis

## Usage

```
nextflow run j23414/bam-subset-reference \
  --samplesheet samplesheet.csv \
  -profile stjude
```

| sample | bam | references |
|:--|:--|:--|
|one | one.bam | GenBank_HA;GenBank_NA |
|two | two.bam | GenBank_HA;GenBank_PB2;GenBank_PB1;GenBank_NP |


## Output

A non-exaustive list of outputs

```
|_ subset-results/
  |_ subset_bam/         # <= Subsetted alignments, can send to variant, depth, consensus, or filter calling
  |_ processed_samplesheet.tsv # <= samplesheet to use in downstream pipelines
```
