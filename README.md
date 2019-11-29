# AiiDA setup for LSMO members

## 1. install prerequisites

[Install prerequisites](https://aiida-core.readthedocs.io/en/latest/install/quick_installation.html#prerequisites)
from the AiiDA documentation.

## 2. install conda and create a new environment

If not yet present, [install conda](https://docs.conda.io/en/latest/miniconda.html):
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
source "$HOME/miniconda/etc/profile.d/conda.sh"
conda init
```
Create an enviroment `aiida1` with python 3.6 and activate this new environment
```
conda create -n aiida1 python=3.6 -y
conda activate aiida1
```
Remember to always activate the environment before starting to use AiiDA.

## 3. create a directory to gather AiiDA related files

```
mkdir -p $HOME/aiida1
cd $HOME/aiida1
git clone https://github.com/lsmo-epfl/aiida-lsmo-setup.git
export AIIDA_PATH=${HOME}/aiida1
```

## 4. install AiiDA and plugins

#### preferable choice: install from Github in editable mode
This allows you to easily edit the AiiDA plugin packages and contribute back changes upstream:
```
./aiida-lsmo-setup/install_editable.sh
```
#### alternative choice: install from PyPI
This will use packaged versions of all plugins - easier to install:
```
./aiida-lsmo-setup/install_packages.sh
```

## 5. add variables to environment
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

## 6. make your AiiDA profile

Run and follow the instructions of
```
verdi quicksetup
```
and check that everything is fine with:
```
verdi status
```
The only red cross should be for the *daemon*, that you will need to start later in order to submit a calculation.

## 7. install computers and codes

### Setting up passwordless SSH access

If you haven't done so already

 * generate a ssh keypair using `ssh-keygen -t rsa`
 * set up passwordless access using `ssh-copy-id username@remote`

See also [the AiiDA documentation](https://aiida-core.readthedocs.io/en/latest/get_started/computers.html).

### set up AiiDA computers and codes

We have prepared a set of configuration files that allows you to quickly set up computers and codes used in the LSMO:
```
git clone https://github.com/lsmo-epfl/aiida-lsmo-codes --depth 1
cd aiida-lsmo-codes
./configure.py
```

This scripts automates three steps: `verdi computer setup`, `verdi code setup` and `verdi computer configure`.
It is important that you understand also the manual configuration from
[the AiiDA documentation](https://aiida-core.readthedocs.io/en/latest/get_started/computers.html#computer-setup-and-configuration)
to be able to add/modify/delete new codes and computers.

Note that:
* if a computer with the same name exists it won't be updated. One solution can be to `verdi computer rename` the label
  of the previous computer, and also the label of the codes (i.e., `code@computer`) will be renamed.
* if a code with the same label exists, it gets duplicated and the label is not anymore unique and you will need to use
  its *PK* to load it). If this happens with `./configure.py`, you possibly ran the script twice, and you have better remove
  the duplicate with `verdi code delete` (or, if you already used it `verdi node delete {PK}`, but all your calculations
  associated to this code will also be removed!)

### test computers
```
verdi computer test fidis
```

## 8. try out some examples

Now that (some of) your computers and codes are configured, you can see them listed with `verdi code list`.
You are ready to run some quick examples of work chains from the
[aiida-lsmo repository](https://github.com/lsmo-epfl/aiida-lsmo).
For example:
```
cd aiida-lsmo/examples
verdi run run_IsothermWorkChain_HKUST-1.py raspa@localhost zeopp@localhost
```
Read [here the documentation](https://aiida-lsmo.readthedocs.io/) of LSMO's work chain and calculation functions.
