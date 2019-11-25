#!/bin/bash
set -ex

git clone https://github.com/lsmo-epfl/aiida-lsmo-codes --depth 1
cd aiida-codes

for computer in fidis fidis-s6g1 deneb; do 
    ./setup.py --computer $computer
done

cd ..
