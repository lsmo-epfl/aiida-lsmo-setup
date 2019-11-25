#!/bin/bash
set -ex

AIIDA_DIR=$AIIDA_PATH
mkdir -p $AIIDA_DIR
cd $AIIDA_DIR

git -C aiida-core pull | git clone https://github.com/aiidateam/aiida-core.git
pip install -e aiida-core[testing,notebook]

git -C aiida-cp2k pull | git clone https://github.com/aiidateam/aiida-cp2k.git
pip install -e aiida-cp2k

git -C aiida-ddec pull | git clone https://github.com/yakutovicha/aiida-ddec.git
pip install -e aiida-ddec

git -C aiida-zeopp pull | git clone https://github.com/ltalirz/aiida-zeopp.git
pip install -e aiida-zeopp

git -C aiida-raspa pull | git clone https://github.com/yakutovicha/aiida-raspa.git
pip install -e aiida-raspa

git -C calc_pe pull | git clone https://github.com/danieleongari/calc_pe.git
pip install -e calc_pe

git -C aiida-lsmo pull | git clone https://github.com/yakutovicha/aiida-lsmo.git
pip install -e aiida-lsmo

reentry scan
