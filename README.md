######## UNDER DEVELOPMENT #########

# Mass-ParamSpider: Run ParamSpider tool on multiple domains or subdomains.

## Installation:
```
git clone https://github.com/xalgord/Mass-ParamSpider
cd Mass-ParamSpider
sudo chmod +x mass-param.txt
```

Note: `paramspider` and `httprobe` should be added to the $PATH or in the bin folder, for example:

```
$ sudo cp -r ParamSpider/* /usr/local/bin/
```

## Usage:
```
./paramspider_script.sh domains.txt
```
In the `domains.txt`, you can supply all the subdomains of a domain or the mutiple domains. Filename should be `domains.txt`.
