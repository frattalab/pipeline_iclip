# Snakemake Pipeline for processing iCLIP data

Barebones, choppy pipeline to process iCLIP data. See config/config.yaml for basic usage instructions

As it stands, I just want to merge BEDs of cross-link positions (downloaded from iMAPs web server (generated using iCount)) & identifying 'peaks' or significant x-link positions using iCount's randomisation approach.

I wanted to use iCount's snakemake pipeline, but looks to be work in progress (not fully documented yet) and I also would've had to spend a bit of time re-naming files to match declarations in pipeline etc... though maybe this was just an excuse to write a new pipeline...
