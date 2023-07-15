# Mass-ParamSpider: Run ParamSpider tool on multiple domains or subdomains.

## Features:
- Scrape all Parameters of multiple domains and subdomains in one shot.
- ~Checks the dead domains using curl before executing the script~.
- ~Using parallel to make the process faster~.


## Requirements:
```
sudo apt install python3
```

## Installation:
```
git clone https://github.com/xalgord/Mass-ParamSpider
cd Mass-ParamSpider
sudo chmod +x mass-param.sh
```

Note: [ParamSpider](https://github.com/devanshbatham/ParamSpider) should be installed in your system and added to the $PATH, for example:

```
nano ~/.bashrc
export PATH="$PATH:$HOME/bbtools/ParamSpider/"
source ~/.bashrc
```

## Usage:
```
./mass-param.sh domains.txt
```
In the `domains.txt`, you can supply all the subdomains of a domain or the mutiple domains.
