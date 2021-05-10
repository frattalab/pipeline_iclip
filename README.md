# Snakemake Pipeline for processing iCLIP data

Barebones, choppy pipeline to call peaks on iCLIP from cross-linked read BED files using [iCount](https://github.com/tomazc/iCount). See below and config/config.yaml for basic usage instructions.

As it stands, I just want to merge BEDs of cross-link positions (can be generated using iCount, some data is available on from iMAPs web server) & identifying 'peaks' or significant x-link positions using iCount's randomisation approach.

Before using this, I would recommend keeping an eye on the snakemake pipeline under development (see forks) in the main [iCount repo](https://github.com/tomazc/iCount) and the now published [nf-core clip-seq pipeline](https://nf-co.re/clipseq). I was not convinced I could get it running for our purposes on the UCL CS cluster, and so this hacky pipeline was born.

If you care, see my notes at end of readme on what I tried to do and other thoughts on why the main repo pipeline was unlikely to work...



## Setup instructions

1. **Create conda environment named `iCount` using provided environment file**

```
conda env create -f=environment_icount.yaml
```

Warning: this can be quite slow...

2. **Activate iCount conda environment**

```
conda activate iCount
```

3. **Clone the iCount github repository**

You can use the fork I've made (https://github.com/SamBryce-Smith/iCount) or clone from the [main Github respository](https://github.com/tomazc/iCount). It doesn't really matter where you clone it to either, but for simplicities sake do it relative to this directory.

```
git clone https://github.com/SamBryce-Smith/iCount
```

4. **Change to cloned iCount directory and install iCount with pip**

```
cd iCount
pip install -e .[test]
```

(Thanks for instructions in [iCount readthedocs](https://icount.readthedocs.io/en/latest/contributing.html#installation-for-development))

5. **See if have problem importing pysam at python interactive terminal**

There seems to be a fairly common  error when installing samtools 1.9 / it's dependencies through conda. You get an error along the lines of:

`error while loading shared libraries: libcrypto.so.1.0.0: cannot open shared object file: No such file or directory`

One way to check this is to try and load the pysam library at the python interactive terminal. Try the following (with iCount conda env active):

```
(iCount) [sbrycesm@morecambe2 pipeline_iclip]$ python
```

(the interactive shell should look something like)
```
Python 3.6.10 | packaged by conda-forge | (default, Apr 24 2020, 16:44:11)
[GCC 7.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>>
```

At the interactive shell, type
```
>>> import pysam
```
If you don't get an error, you're free to skip to running the pipeline! If you get an error like

```
Put in the error message Sam! Conda is being very very slow...
```

You can solve this by lying to samtools/pysam about libcrypto.so.1.0.0 being installed by soft-linking to libcrypto.so.1.1 (it still works perfectly with 1.1)

Change to 'lib' directory of your iCount conda installation. By default this will be something like `~/.conda/envs/iCount/lib`, but you can double check by running `conda env list` at the command line.

```
cd ~/.conda/envs/iCount/lib
ls libcrypto*
ln -s libcrypto.so.1.1 libcrypto.so.1.0.0
```

Loading pysam at the interactive shell should now work without erros!

I got the solution from the [following issue (thanks zyllifeworld!)](https://github.com/bioconda/bioconda-recipes/issues/12100).


## Running instructions

Update the config file `config/config.yaml` with run specific information. Notes are currently minimal, if you're not sure about what to do just ask me. Some parameters are specific to `iCount peaks` command - if you want to customise I'd recommend reading the iCount readthedocs to know what you're getting into.

When you are ready, you can do a dry run with
```
snakemake -n -p -s pipeline_iclip.smk
```

If everything looks in order, you can submit to the UCL SGE cluster using the `submit_dirty_pipeline_iclip.sh` submit script

```
qsub submit_dirty_pipeline_iclip.sh
```

feel free to change the job name specified in the script (by default it is set to `iclip_pipeline_submit`).

When I work out a way to get an automatic installation working, I will switch the the classical job-submit approach.


### Venting about my difficulties with setting up iCount...

I tried... everything...
1. As pipeline is on master (Oct 2020), the conda environment file is not declared for each rule, so `--use-conda` will not create conda environments for pipeline (i.e. can't run through submitted jobs). The env file also does not install iCount automatically, so it wouldn't work if I added `conda: "<env_file.yaml>"` to each rule.

    - I tried modifying env file to install iCount automatically via pip, but I left it running overnight and it still didn't resolve...

2. Asking singularity to pull the docker container (and declaring it for each rule) didn't work. For whatever reason, the container singularity pulls/creates doesn't have iCount installed/available in $PATH (STAR does install, so something funky going on... Docker image run with Docker works perfectly on local machine though))

3. The latest version of iCount available through pip is 2.0.0, released in 2017. This actually won't install with a simple `pip install iCount` ([see issue I opened](https://github.com/tomazc/iCount/issues/199])). It turns out that this only version is tagged for up to python 3.5 (but conda env file and docker user specify python 3.6...)


### To do
icount is on bioconda - use that to install dependencies instead of the one-by-one approach
