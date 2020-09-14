# AiiDA setup for LSMO members

## 1. install prerequisites

[Install prerequisites](https://aiida.readthedocs.io/projects/aiida-core/en/latest/intro/installation.html#intro-install-prerequisites)
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
Conda executes scripts in a special `activate.d` folder upon activating an environment.
Add there any custom commands, e.g., aliases, you want to use with AiiDA (instead of placing them in your `.bashrc`).
```
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
cat > $CONDA_PREFIX/etc/conda/activate.d/aiida-init.sh << EOF
export AIIDA_PATH=$HOME/aiida1
eval "\$(_VERDI_COMPLETE=source verdi)"
EOF
```
Here, we have specified the `AIIDA_PATH` and enabled tab-autocompletion for the `verdi` commands.

Now, let's exit and reenter the environment in order for the changes to take effect:
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
The only red cross should be for the *daemon*, that you will start later before submitting a calculation.

## 7. install computers and codes

### Setting up passwordless SSH access

If you haven't done so already

 * generate a ssh keypair using `ssh-keygen -t rsa`
 * set up passwordless access using `ssh-copy-id username@remote` for the clusters you want to use with AiiDA (e.g. fidis, deneb)

See also [the AiiDA documentation](https://aiida.readthedocs.io/projects/aiida-core/en/latest/howto/ssh.html).

### set up AiiDA computers and codes

We have prepared a set of configuration files that allows you to quickly set up computers and codes used in the LSMO:
```
git clone https://github.com/lsmo-epfl/aiida-lsmo-codes --depth 1
cd aiida-lsmo-codes
./configure.py
```

This scripts automates three steps: `verdi computer setup`, `verdi computer configure` and `verdi code setup`,
which you can use whenever you need to add/modify/delete computers and computers.
See [the AiiDA documentation](https://aiida.readthedocs.io/projects/aiida-core/en/latest/howto/run_codes.html?highlight=computers#managing-your-computers) for more information.

Note:
* if a computer with the same name exists it won't be set up again. You can `verdi computer rename` the label the previous computer.
* if a code with the same label exists, it *will* set up a new code with the same label, so the label is no longer unique (you will need to use the *PK* to refer to the code).
  You can remove codes using `verdi node delete <PK>` (note: all calculations associated to the code will also be removed).

### test computers
```
verdi computer list
verdi computer test fidis
verdi code list
```

## 8. try out some examples

You are ready to run your first work chains from the [aiida-lsmo repository](https://github.com/lsmo-epfl/aiida-lsmo).
For example:
```
cd aiida-lsmo/examples
verdi run run_IsothermWorkChain_HKUST-1.py raspa@localhost zeopp@localhost
```
See [the documentation](https://aiida-lsmo.readthedocs.io/) of LSMO's work chain and calculation functions.
