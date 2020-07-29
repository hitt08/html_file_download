## Quick Start
```
download_file.sh -u <URL> [-o OUTPUT_FILE_NAME]
download_file.sh -f <URL_LIST_FILE>

<URL_LIST_FILE>-
<URL1>
<URL2>,<OUTPUT_FILE_NAME2>
<URL3>,<OUTPUT_FILE_NAME3>
<URL4>
<URL5>
```
## Syntax
```
bash download_file.sh [OPTION]
OPTIONS
  -p, --pattern   File Pattern, Default: mp4
  -u|--url        Web URL
  -o|--outname    Output File Name, Default: Same as web
  -f|--file       File with list of WebURL[,OutputFileName] (separated in each line)
  ```
