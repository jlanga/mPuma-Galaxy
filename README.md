mPuma-Galaxy (0.0.1)
====================

About
-----

A re-implementation of the mPuma pipeline (http://mpuma.sourceforge.net/) for the Galaxy platform (http://galaxyproject.org/). mPuma does bla bla bla ... 

The original mPuma pipeline has been decomposed into independent and usefull tools. The pipeline is already installed and tested at biordf:8093. You can have a look at this Galaxy page for a test dataset and workflow (original study to test mPuma). 

The workflow can be found at: 

You can also install the tool suite at your own Galaxy server, see bellow for details.

mPuma-Galaxy is a collection of newly developed and already existing Galaxy tools. The new tools are ... For the already exisintg tools see dependencies bellow 

Installation
------------

### Dependencies

System dependencies (You can check that they are met by runing the Galaxy functional tests, e.g. `./run_functional_tests.sh -id Shannon`):

* R 3.0 or higher
* Rscript
* R packages: biom, vegan
* Bioperl?

Galaxy dependencies (Galaxy tools that should be installed in Galaxy):

* Galaxy tools included in a default Galaxy installation (No need to install but included here for completeness):

..* Convert formats; SFF converter

* Extra galaxy tools that need to be installed from the tool shed:

..* NGS RNA analysis ; De novo assembly; trinity (included by need to uncomment and edit!!!)

..* blastx old 

### Procedure

No toolshed version yet for automated installation. Stop Galaxy and either:

* Unpack and execute `deploy-mPuma-Galaxy.sh` at your own risk. The script will copy the necessary files and edit `tool-conf.xml`. You need to edit the `galaxy` variable and add the path to yor galaxy distribution.

* Unpack and install manually (perform the steps that are automated by the above script). Copy the whole directory `galaxy-dist/tools/mPuma/` to the `tools` directory on your Galaxy system. Same for `test-data`. Then edit `tool-conf.xml` to include the same content as `galaxy-dist/tool_conf.xml`, except the `</toolbox>` tag. This way you can the mPuma tool suite in the place you like in the menu. 

Start Galaxy.

Funding
-------

Mikel Egaña Aranguren is funded by the Marie Curie Cofund programme (FP7) of the European Union through the UPM (Spain).