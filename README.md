# Mass-ParamSpider: Run ParamSpider tool on multiple domains.

## Installation:
```
git clone https://github.com/xalgord/Mass-ParamSpider
cd Mass-ParamSpider
sudo chmod +x mass-param.txt
```

Note: Add the `paramspider` and `httprobe` should be in the bin folder, for example:

```
$ cd ParamSpider
$ sudo cp paramspider.py /usr/local/bin/
```

## Usage:
```
./paramspider_script.sh domains.txt
```
In the `domains.txt`, you can supply all the subdomains of a domain or the mutiple domains. Filename should be `domains.txt`.
