# Docker Blueprint for GQRX with PlutoSDR

> Gqrx is an open source software defined radio receiver (SDR) powered by the GNU Radio and the Qt graphical toolkit - [Official Project Repository](https://github.com/csete/gqrx)


## Installation

```bash
git clone https://github.com/va1da5/docker-gqrx-pluto.git
cd docker-gqrx-pluto
./build.sh
```

## Usage

```bash
./run.sh
```

You can also simulate native binary using the following:

```bash
mkdir ~/bin
cp run.sh ~/bin/gqrx
chmod +x ~/bin/gqrx
gqrx # start a container from anywhere in CLI
```
