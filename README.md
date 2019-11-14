# AiiDA setup for LSMO members

## 1. install conda

If not yet present, [install conda](https://docs.conda.io/en/latest/miniconda.html):
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
conda init
conda create -n aiida1 python=3.6
conda activate aiida1
```

## 2. install prerequisites

[Install prerequisites](https://aiida-core.readthedocs.io/en/latest/install/quick_installation.html#prerequisites) from the AiiDA documentation.

## 3. install aiida and plugin

#### Variant 1: install from PyPI
```
export AIIDA_PATH=${HOME}/aiida1
source install_packages.sh
```

#### Variant 2: install from GitHub (editable)
```
export AIIDA_PATH=${HOME}/aiida1
source install_editable.sh
```

## 4. install computers and codes
Change the `username` in `computer-configure.yml` to your username and run:
```
git clone https://github.com/danieleongari/aiida-codes --depth 1
cd aiida-codes

./setup.py
```
