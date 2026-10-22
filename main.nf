workflow {
    main:
    // Load bam alignments
    if (params.samplesheet) {
      // sample,bam,reference
      bam_ch = channel.fromPath(params.samplesheet)
        | splitCsv(header: true)
        | map { row ->
            def reference_id = row.reference.split("\\|")[0]
            tuple([id: row.sample, reference_id: reference_id], file(row.bam))
          }
    } else {
        error "Please specify --samplesheet samplesheet.csv"
    }

    // Load reference
    reference_ch = channel.fromPath(params.reference, checkIfExists: true)
}
