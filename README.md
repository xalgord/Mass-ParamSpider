######## UNDER DEVELOPMENT #########

# Mass-ParamSpider: Run ParamSpider tool on multiple domains or subdomains.

## Installation:
```
git clone https://github.com/xalgord/Mass-ParamSpider
cd Mass-ParamSpider
sudo chmod +x mass-param.txt
```

Note: `paramspider` and `httprobe` should be added to the $PATH, for example:

```
$ nano ~/.bashrc
$ export PATH="/bbtools/ParamSpider:$PATH"
$ source ~/.bashrc
```

## Usage:
```
./paramspider_script.sh domains.txt
```
In the `domains.txt`, you can supply all the subdomains of a domain or the mutiple domains. Filename should be `domains.txt`.
