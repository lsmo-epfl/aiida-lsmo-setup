# AiiDA setup for LSMO members

## 0. create a directory to gather AiiDA related files

```
mkdir $HOME/aiida1
cd $HOME/aiida1
git clone https://github.com/lsmo-epfl/aiida-lsmo-setup.git
export AIIDA_PATH=${HOME}/aiida1
```

## 1. install conda and create a new environment

If not yet present, [install conda](https://docs.conda.io/en/latest/miniconda.html):
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
conda init
```

Create an enviroment called `aiida1` using python 3.6, proceed with the installation of the suggested minimal packages,
and activate this new environment (remember to always activate the environment when using AiiDA!).
```
conda create -n aiida1 python=3.6
conda activate aiida1

```

## 2. install prerequisites

[Install prerequisites](https://aiida-core.readthedocs.io/en/latest/install/quick_installation.html#prerequisites)
from the AiiDA documentation.

## 3. install AiiDA and plugins

#### preferable choice: install from Github in editable mode
```
./aiida-lsmo-setup/install_editable.sh
```
#### alternative choice: install from PyPI
```
./aiida-lsmo-setup/install_packages.sh
```

## 4. add variables to environment
```
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
cat > $CONDA_PREFIX/etc/conda/activate.d/aiida-init.sh << EOF
export AIIDA_PATH=$HOME/aiida1
eval "\$(_VERDI_COMPLETE=source verdi)"
EOF
```
Note that scripts in `activate.d` are executed at the activation of the environment.
Therefore, you can add here custom commands, e.g., aliases, that you want to use with AiiDA,
instead of having them in your `.bashrc`.

To make effective the `eval` for the command line autocompletion, restart your environment.
Note that `deactivate` allow you to come back to your main (i.e., `base`) python environment.

```
conda deactivate
conda activate aiida1
```

## 5. make your AiiDA profile

Run and follow the instructions of
```
verdi quicksetup
```
and check that everything is fine with:
```
verdi status
```
The only red cross should be for the *daemon*, that you will need to start later in order to submit a calculation.

## 6. install computers and codes

### set up AiiDA computers and codes
```
git clone https://github.com/lsmo-epfl/aiida-lsmo-codes --depth 1
cd aiida-lsmo-codes

./setup.py
```

### generating a ssh keypair

If you haven't done so already, generate a ssh keypair using `ssh-keygen -t rsa` and `ssh-copy-id username@remote`
(see also [the AiiDA documentation](https://aiida-core.readthedocs.io/en/latest/get_started/computers.html)).

### configure localhost
```
verdi computer configure local localhost
```

### configure clusters

Change the `username` in `aiida-lsmo-setup/computer-configure.yml` to your username on the cluster, and run:
```
verdi computer configure ssh fidis --config computer-configure.yml
```
Press enter to confirm all the other default settings.

### test computers
```
verdi computer test fidis
```
