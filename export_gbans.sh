
if [ "$1" ]; then
echo $1
declare -a DATE
DATE=$(date +%F)
cat $1 | grep -E [0-9] |  sed 's/    /['${DATE}' --> EXPORTED (/g' | sed 's/,/)]/g' >> settings/gbans
fi

if [ ! "$1" ]; then
echo 'ERROR. You need set the file then'
fi
