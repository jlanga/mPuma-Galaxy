mPuma-Galaxy (0.0.1)
====================

About
-----

This is a new implementation of the mPuma pipeline (http://mpuma.sourceforge.net/) for the Galaxy platform (http://galaxyproject.org/). mPuma allows researchers to profile microbial communities using a *de novo* assembly approach to form Operational Taxonomic Units (OTUs). While originally designed to support the analysis of cpn60 based amplicons, mPUMA can be used to analyze data from any suitable DNA barcode.

The original mPuma pipeline was implemented as a standalone terminal program. For this new implementation it has been decomposed into a suite of independent tools: the mPuma pipeline is executed as a Galaxy workflow, making it easier to run, debug, and generally more usefull, since some of the tools are new and also subpipelines can be easilly configured.

The pipeline is already installed at http://biordf.org:8983 (See section **Using mPuma-Galaxy** bellow). You can also install the tool suite at your own Galaxy server (recommended) following the instructions of the section **Installation** bellow.

Installation
------------

### Requirements

Server dependencies (You can check that they are met by runing the Galaxy functional tests, e.g. `./run_functional_tests.sh -id Shannon`). Make sure they are available in the `$PATH` env variable:

* R 3.0 or higher (including packages biom, vegan, ...)
* Rscript (/usr/bin/Rscript in ubuntu)
* Perl modules: Bio::SeqIO

Galaxy dependencies:

* Galaxy tools included in a default Galaxy installation (No need to install but added here for completeness):
  * Convert formats; SFF converter
  * NGS: QC and manipulation; FASTQ groomer
  * Bowtie2
  
* Galaxy tools included in a default Galaxy installation but need some configuration:
  * NGS RNA analysis; De novo assembly; trinity: uncomment in tool_conf.xml

* Extra galaxy tools that need to be installed through the tool-shed:
  * CD-HIT
  * NGS: SAM tools (see http://wiki.galaxyproject.org/Admin/NGS%20Local%20Setup)
  * BLASTX
  * gsAssembler (Roche 454 tool suite)
  
* All the Galaxy tools included in this bundle (See Procedure bellow to install): 
  * Simpson
  * Shannon
  * create_ace_toc_SAM 
  
### Procedure

In order to install the tools of this bundle, there is no toolshed version yet for automated installation. Stop Galaxy and either:

* Unpack and execute `deploy-mPuma-Galaxy.sh` at your own risk. The script will copy the necessary files and edit `tool-conf.xml`. You need to edit the `galaxy` variable and add the path to your galaxy distribution.

* Unpack and install manually (perform the steps that are automated by the above script). Copy the whole directory `galaxy-dist/tools/mPuma/` to the `tools` directory on your Galaxy system. Same for `test-data`. Then edit `tool-conf.xml` to include the same content as `galaxy-dist/tool_conf.xml`, except the `</toolbox>` tag. This way you can add the mPuma tool suite wherever you like on the Galaxy left column. 

Start Galaxy.

Using mPuma-Galaxy
------------------

The Galaxy page (URL) contains a workflow and history representing the mPuma pipeline, using a test dataset from the original publication. The pipeline can be run by importing both the history and the workflow and executing the workflow with the datasets from the history (We recommend doing this in your own Galaxy server). 

Notes:

* Use the NGS: QC and manipulation; FASTQ groomer to prepare FASTQ file for bowtie2

Funding
-------

Mikel Egaña Aranguren is funded by the Marie Curie Cofund programme (FP7) of the European Union through the UPM (Spain) and the Genomic Resources Group (http://www.genomic-resources.eu/) of the University of Basque Country (UPV/EHU).