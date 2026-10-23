# Software Development Document

Keep track of design decisions and criteria.

Problem Statement: 

Illumina reads have been multi-aligned to a subsampled collection of references. We know the best hit based on the coverage and depth information and have that information in a tab delimited file. This pipeline allows us subset the bam alignments to reads against the best hit (or other criteria) references in a smaller bam files before downstream analysis. The difference from `bam-filter` is that `bam-filter` is based on alignment base quality, trimming primers, deduplicating, and depth. The `bam-subset-reference` is subsetting based on genomic regions.

Design preferences:
* Preferentially use nf-core/modules instead of reimplementing custom tooling
* Preferentially use existing tools instead of reinventing
* Prefer the faster to the slower methods
* Prefer tooling with less dependencies to more dependencies
* Prefer ease of reading and maintenance over speed (e.g. reimplement everything in byte code results in faster runtime but terrible to maintain)
* Prefer tooling familiar to bioinformaticians unless the speedup is 10x and the new tool has active development and a growing team
* Prefer implementing the core algorithm, but leave open the door to add data input and output validation later on
* Prefer samplesheet input
* The results MUST be accurate

I should add tests...