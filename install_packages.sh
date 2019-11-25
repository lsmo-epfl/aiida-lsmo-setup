#!/bin/bash
AIIDA_DIR=$AIIDA_PATH
mkdir -p $AIIDA_DIR
conda install -c conda-forge aiida-core
pip install aiida-lsmo
reentry scan
