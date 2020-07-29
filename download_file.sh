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
      echo "$1 [OPTION]"
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
                if [[ -z $vid_url ]];then
                        echo "*."$pattern" Content not found"
                else
                        res="Downloading "$vid_url
                        if [[ ! -z $NAME ]];then
                                n='-O '$NAME.$pattern
                                res=$res" to file "$NAME.$pattern
                        else
                                n=''
                        fi
                        echo $res
                        wget $vid_url $n 2>/dev/null
                fi
        fi
        if [[ ! -z $URL_FILE ]];then
                while read line; do
                        url=`echo $line | awk -F "," '{print $1}'`
                        name=`echo $line | awk -F "," '{print $2}'`
                        vid_url=`curl -L $url 2>/dev/null |awk -v var=$pattern -F "$pattern" '{print $1 var}' | awk -F '="' '{print $NF}' | tail -1`
                        if [[ ! -z $vid_url ]];then
                                res="Downloading "$vid_url
                                if [[ ! -z $name ]];then
                                        n='-O '$name.$pattern
                                        res=$res" to file "$name.$pattern
                                else
                                        n=''
                                fi
                                echo $res
                                wget $vid_url $n 2>/dev/null
                        fi
                done < $URL_FILE
        fi
fi
