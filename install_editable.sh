#!/bin/bash
AIIDA_DIR=$AIIDA_PATH
mkdir -p $AIIDA_DIR
cd $AIIDA_DIR

git clone https://github.com/aiidateam/aiida-core.git
pip install -e aiida-core[testing]

git clone https://github.com/aiidateam/aiida-cp2k.git
pip install -e aiida-cp2k

git clone https://github.com/yakutovicha/aiida-ddec.git
pip install -e aiida-ddec

git clone https://github.com/ltalirz/aiida-zeopp.git
pip install -e aiida-zeopp

git clone https://github.com/yakutovicha/aiida-raspa.git
pip install -e aiida-raspa

git clone https://github.com/danieleongari/calc_pe.git
pip install -e calc_pe

git clone https://github.com/yakutovicha/aiida-lsmo.git
pip install -e aiida-lsmo

reentry scan

cd ..
