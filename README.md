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

### set up AiiDA computers and codes
```
git clone https://github.com/danieleongari/aiida-codes --depth 1
cd aiida-codes

./setup.py
```

### generating a ssh keypair

If you haven't done so already, generate a ssh keypair using `ssh-keygen -t rsa` and `ssh-copy-id username@remote` (see also [the AiiDA documentation](https://aiida-core.readthedocs.io/en/latest/get_started/computers.html)).

### configure computers

Change the `username` in `computer-configure.yml` to your username and run:
```
verdi computer configure localhost local
verdi computer configure fidis ssh --config computer-configure.yml
verdi computer configure deneb ssh --config computer-configure.yml
```

### test computers
```
verdi computer test fidis
```
