pattern=mp4
URL=""
URL_FILE=""
NAME=""
NAME_FILE=""
BREAK=0

while [[ "$#" -gt 0 ]];do
  case $1 in
    -p|--pattern)
      pattern=$2
      ;;
    -u|--url)
      URL=$2
      ;;
    -f|--file)
      URL_FILE=$2
      ;;
    -o|--outname)
      NAME=$2
      ;;
    -O|--outnamefile)
      NAME_FILE=$2
      ;;
    -h|--help)
      BREAK=1
      echo "download_file.sh [OPTION]"
          echo "  -p, --pattern   File Pattern, Default: ${pattern}"
          echo "  -u|--url        Web URL"
          echo "  -f|--file       File with list of WebURL[,OutputFileName] (separated in each line)"
          echo "  -o|--outname    Output File Name, Default: Same as web"
      ;;
  esac
  shift
done

if [ $BREAK -eq 0 ];then
        if [[ ! -z $URL ]];then
                vid_url=`curl -L $URL 2>/dev/null |awk -v var=$pattern -F "$pattern" '{print $1 var}' | awk -F '="' '{print $NF}' | tail -1`
                res="Downloading "$vid_url
                if [[ ! -z $NAME ]];then
                                n='-O '$NAME
                        res=$res" to file "$NAME
                else
                                n=''
                fi
                echo $res
                wget $vid_url $n 2>/dev/null
        fi
        if [[ ! -z $URL_FILE ]];then
                while read line; do
                        url=`echo $line | cut -d "," -f1`
                        name=`echo $line | cut -d "," -f2`

                        vid_url=`curl -L $url 2>/dev/null |awk -v var=$pattern -F "$pattern" '{print $1 var}' | awk -F '="' '{print $NF}' | tail -1`
                        res="Downloading "$vid_url
                        if [[ ! -z $name ]];then
                                        n='-O '$name
                                res=$res" to file "$name
                        else
                                        n=''
                        fi
                        echo $res
                        wget $vid_url $n 2>/dev/null
                done < $URL_FILE
        fi
fi
