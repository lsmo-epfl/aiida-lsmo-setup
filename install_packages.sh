#!/bin/bash
set -ex
conda install -c conda-forge aiida-core -y
pip install aiida-lsmo
reentry scan
