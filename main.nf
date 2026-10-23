process SAMTOOLS_SUBSET {
    tag "${meta.id}"
    label 'process_medium'

    conda "./modules/nf-core/samtools/index/environment.yml"
    container "${workflow.containerEngine in ['singularity', 'apptainer']
        ? 'https://community-cr-prod.seqera.io/docker/registry/v2/blobs/sha256/8c/8c5d2818c8b9f58e1fba77ce219fdaf32087ae53e857c4a496402978af26e78c/data'
        : 'community.wave.seqera.io/library/htslib_samtools:1.23.1--5b6bb4ede7e612e5'}"

    input: tuple val(meta), file(bam), val(references)
    output: tuple val(meta), file("${bam.baseName}_subset.bam"), val(references), file("${bam.baseName}_script.sh")
    script:
    def reference_names = references.split(';').collect { reference -> "'${reference}'" }.join(' ')
    """
    # sort
    # index
    # filter
    # sort
    # index

    echo "samtools view -b -o ${bam.baseName}_subset.bam ${bam} ${reference_names}" > ${bam.baseName}_script.sh
    touch ${bam.baseName}_subset.bam
    """
}

workflow {
    main:
    // Load bam alignments
    if (params.samplesheet) {
      // sample,bam,reference
      bam_ch = channel.fromPath(params.samplesheet)
        | splitCsv(header: true)
        | map { row ->
            tuple([id: row.sample], file(row.bam), row.references)
          }
    } else {
        error "Please specify --samplesheet samplesheet.csv"
    }

    SAMTOOLS_SUBSET(bam_ch) | view

    SAMTOOLS_SUBSET.out
    .map {meta, bam, references, _script -> "${meta.id},subset_bam/${bam.fileName},${references}"}
    .collectFile(
        name: "${params.outdir}/processed_samplesheet.csv",
        seed: "sample,bam,references",
        newLine: true,
    )
}
