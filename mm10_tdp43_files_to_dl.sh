#!/usr/bin/env/bash


#Want to combine published TDP-43 iCLIP files into single BED
#Download xlinks & processing stats from iMAPs server
#Merge all xlink files into single BED file & perform iCount peaks/ sig x-link bases analysis on combined file

#Download was performed on 12/10/20 - If download from URLs at later point, content may differ
# Searched "TARDBP Mus musculus"
# All samples from following 'Experiments' - "TARDBP_FRATTA", "Binding of FUS regulates alternative splicing in brain", "TDP-43 iCLIP in mESCs"

#To download QC stats - I used Web UI, selected all samples from above search result (individually DL'd below),
#Clicked Download Tab, marked tick boxes for "Data QC: Reads, Alignment" & "Cross-links: Download" & downloaded zipped results file
#Was too lazy to get individual links from web-page...

#looking back I think the -P & -O options are redundant (only 1 file DL'd and specify its path with -O)...

set -euo pipefail

date
######## X-link BEDs
mkdir mm10_tdp_xlinks

## TARDBP_FRATTA
mkdir mm10_tdp_xlinks/tardbp_fratta

wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-migg-20151221-ju2_trimmed_single.bed.gz \
https://imaps.genialis.com/data/74959/tardbp-brain-brain-migg-20151221-ju2_trimmed_single.bed.gz?force_download=1 

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-migg-20151221-ju2_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-migg-20151221-ju2_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-wtbl6-20151221-ju2_trimmed_single.bed.gz \
https://imaps.genialis.com/data/74951/tardbp-brain-brain-wtbl6-20151221-ju2_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-wtbl6-20151221-ju2_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-wtbl6-20151221-ju2_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-migg-20151221-ju2_trimmed_single.bed.gz \
https://imaps.genialis.com/data/75015/tardbp-brain-embryo-brain-migg-20151221-ju2_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-migg-20151221-ju2_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-migg-20151221-ju2_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-wtbl6-20151221-ju2-1_trimmed_single.bed.gz \
https://imaps.genialis.com/data/74943/tardbp-brain-brain-wtbl6-20151221-ju2-1_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-wtbl6-20151221-ju2-1_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-wtbl6-20151221-ju2-1_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-wtbl6-20151221-ju2_trimmed_single.bed.gz \
https://imaps.genialis.com/data/75007/tardbp-brain-embryo-brain-wtbl6-20151221-ju2_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-wtbl6-20151221-ju2_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-wtbl6-20151221-ju2_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-wtbl6-20151221-ju2-2_trimmed_single.bed.gz \
https://imaps.genialis.com/data/74991/tardbp-brain-embryo-brain-wtbl6-20151221-ju2-2_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-wtbl6-20151221-ju2-2_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-wtbl6-20151221-ju2-2_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-wtbl6-20151221-ju2-1_trimmed_single.bed.gz \
https://imaps.genialis.com/data/74999/tardbp-brain-embryo-brain-wtbl6-20151221-ju2-1_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-wtbl6-20151221-ju2-1_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-wtbl6-20151221-ju2-1_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-muttdp43-m323k-20151221-ju2_trimmed_single.bed.gz \
https://imaps.genialis.com/data/74935/tardbp-brain-brain-muttdp43-m323k-20151221-ju2_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-muttdp43-m323k-20151221-ju2_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-muttdp43-m323k-20151221-ju2_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-muttdp43-m323k-20151221-ju2-1_trimmed_single.bed.gz \
https://imaps.genialis.com/data/74927/tardbp-brain-brain-muttdp43-m323k-20151221-ju2-1_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-muttdp43-m323k-20151221-ju2-1_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-brain-muttdp43-m323k-20151221-ju2-1_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2_trimmed_single.bed.gz \
https://imaps.genialis.com/data/74983/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2-1_trimmed_single.bed.gz \
https://imaps.genialis.com/data/74975/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2-1_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2-1_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2-1_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tardbp_fratta/ \
-a mm10_tdp_xlinks/tardbp_fratta/wget_messages.txt \
-O mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2-2_trimmed_single.bed.gz \
https://imaps.genialis.com/data/74967/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2-2_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2-2_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tardbp_fratta/tardbp-brain-embryo-brain-muttdp43-f210i-20151221-ju2-2_trimmed_single.bed

## Binding of FUS regulates alternative splicing in brain (Boris Rogelj)
mkdir mm10_tdp_xlinks/binding_fus_rojelj

wget -c -P mm10_tdp_xlinks/binding_fus_rojelj/ \
-a mm10_tdp_xlinks/binding_fus_rojelj/wget_messages.txt \
-O mm10_tdp_xlinks/binding_fus_rojelj/tardbp-e18-brain-20091102-lujt5_trimmed_single.bed.gz \
https://imaps.genialis.com/data/73108/tardbp-e18-brain-20091102-lujt5_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/binding_fus_rojelj/tardbp-e18-brain-20091102-lujt5_trimmed_single.bed.gz \
> mm10_tdp_xlinks/binding_fus_rojelj/tardbp-e18-brain-20091102-lujt5_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/binding_fus_rojelj/ \
-a mm10_tdp_xlinks/binding_fus_rojelj/wget_messages.txt \
-O mm10_tdp_xlinks/binding_fus_rojelj/tardbp-e18-brain-20100222-lujt3_trimmed_single.bed.gz \
https://imaps.genialis.com/data/73132/tardbp-e18-brain-20100222-lujt3_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/binding_fus_rojelj/tardbp-e18-brain-20100222-lujt3_trimmed_single.bed.gz \
> mm10_tdp_xlinks/binding_fus_rojelj/tardbp-e18-brain-20100222-lujt3_trimmed_single.bed


## TDP-43 iCLIP in mESCs (Miha Modic)
mkdir mm10_tdp_xlinks/tdp43_mesc_modic

wget -c -P mm10_tdp_xlinks/tdp43_mesc_modic/ \
-a mm10_tdp_xlinks/tdp43_mesc_modic/wget_messages.txt \
-O mm10_tdp_xlinks/tdp43_mesc_modic/tardbp-esc-m-p2lox-gfp-tdp43-20151212_trimmed_single.bed.gz \
https://imaps.genialis.com/data/38229/tardbp-esc-m-p2lox-gfp-tdp43-20151212_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tdp43_mesc_modic/tardbp-esc-m-p2lox-gfp-tdp43-20151212_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tdp43_mesc_modic/tardbp-esc-m-p2lox-gfp-tdp43-20151212_trimmed_single.bed


wget -c -P mm10_tdp_xlinks/tdp43_mesc_modic/ \
-a mm10_tdp_xlinks/tdp43_mesc_modic/wget_messages.txt \
-O mm10_tdp_xlinks/tdp43_mesc_modic/tardbp-ngfp-esc-m-p2lox-gfp-tdp43-20151212_trimmed_single.bed.gz \
https://imaps.genialis.com/data/38217/tardbp-ngfp-esc-m-p2lox-gfp-tdp43-20151212_trimmed_single.bed.gz?force_download=1

gzip -d -c mm10_tdp_xlinks/tdp43_mesc_modic/tardbp-ngfp-esc-m-p2lox-gfp-tdp43-20151212_trimmed_single.bed.gz \
> mm10_tdp_xlinks/tdp43_mesc_modic/tardbp-ngfp-esc-m-p2lox-gfp-tdp43-20151212_trimmed_single.bed 

date
