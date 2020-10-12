configfile: "config/config.yaml"


import os
import sys

indir = config['xlink_beds_input_dir']
outdir = os.path.join(config['output_directory'],'') # '' means always has trailing slash even if specified/not in config
gtf = config['gtf_annotation']
genome_index = config['genome_index_fai']

#define paths to input x-link bed files - these are merged into a single BED file (before x-link analysis)
input_beds = [os.path.join(indir, f) for f in os.listdir(indir) if f.endswith(".bed")]

rule all:
    input:
        outdir + "clusters/" + '.'.join(config['combined_prefix'], "clusters", "min_fdr_" + str(config['peaks_fdr_threshold']), "bed")


rule icount_segment:
    input:
        gtf,
        genome_index,

    output:
        outdir + "segment/" + gtf.rstrip(".gtf") + ".segmented.gtf"

    params:
        outdir + "segment/iCount_segment_metrics.txt"
    log:
        outdir + "segment/iCount_segment.log"

    container:
        "docker://tomazc/icount"

    shell:
        """
        iCount segment -P {log} \
        -F 50 \
        -M {params} \
        {input[0]} {output} {input[1]}
        """

rule icount_merge_bed:
    input:
        input_beds

    output:
        outdir + "group/" + '.'.join([config['combined_prefix'], "xl_sites.bed"])

    params:
        outdir + "group/iCount_group_metrics.txt"

    log:
        outdir + "group/iCount_group.log"

    container:
        "docker://tomazc/icount"

    shell:
        """
        iCount group -P {log} \
        -F 50 \
        -M {params} \
        {output} {input}
        """


rule icount_peaks:
    input:
        xl_bed = outdir + "group/" + '.'.join([config['combined_prefix'], "xl_sites.bed"]),
        segment_gtf = outdir + "segment/" + gtf.rstrip(".gtf") + ".segmented.gtf"

    output:
        outdir + "peaks/" + '.'.join([config['combined_prefix'], "peaks", "min_fdr_" + str(config['peaks_fdr_threshold']), "bed"])

    params:
        metrics = outdir + "peaks/iCount_peaks_metrics.log",
        scores = outdir + "peaks/" + '.'.join([config['combined_prefix'], "scores", "tsv"])
        fdr_cutoff = config['peaks_fdr_threshold'],
        permutations = config['peaks_n_permutations'],
        half_window = config['peaks_half_window'],
        group_by = config['peaks_group_by']

    log:
        outdir + "peaks/iCount_peaks.log"

    container:
        "docker://tomazc/icount"

    shell:
        """
        iCount peaks -P {log} \
        -F 50 \
        -M {params.metrics} \
        --scores {params.scores} \
        --group_by {params.group_by} \
        --half_window {params.half_window} \
        --fdr {params.fdr_cutoff} \
        --perms {params.permutations} \
        {input.segment_gtf} {input.xl_bed} {output}
        """


rule icount_cluster:
    input:
        xl_sites = outdir + "group/" + '.'.join([config['combined_prefix'], "xl_sites.bed"]),
        xl_peaks = outdir + "peaks/" + '.'.join([config['combined_prefix'], "peaks", "min_fdr_" + str(config['peaks_fdr_threshold']), "bed"])

    output:
        outdir + "clusters/" + '.'.join(config['combined_prefix'], "clusters", "min_fdr_" + str(config['peaks_fdr_threshold']), "bed")

    params:
        outdir + "clusters/iCount_clusters_metrics.txt"

    log:
        outdir + "clusters/iCount_clusters.log"

    container:
        "docker://tomazc/icount"

    shell:
        """
        iCount clusters -P {log} \
        -F 50 \
        -M {params} \
        {input.xl_sites} {input.xl_peaks} {output}
        """
