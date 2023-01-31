#!/usr/bin/env bash

INDEX="$1"
PAGE=$(($2 - 1));
PERPAGE=$(($3 + 0));
START=$(($PAGE * $PERPAGE + 1))
STOP=$(($PAGE * $PERPAGE + $PERPAGE))
if [ "$INDEX" == "" ]; then
  echo "No index specified: 0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z"
  exit 1
fi
curl -L https://raw.githubusercontent.com/FETVGuide/livestreams/main/$INDEX.txt -o /tmp/$INDEX.txt
IFS=$(echo -en "\n\b")
for entry in $(sed -n "$START,$STOP"p /tmp/$INDEX.txt); do
  if [ "$entry" != "" ]; then
    echo $entry
    name="$(echo "$entry" | awk '{print $1}')"
    cid="$(echo "$entry" | awk '{print $2}')"
sed 's/^ *//' > ./$cid.txt <<EOL
$(yt-dlp --get-id https://www.youtube.com/@$name)
EOL
    for vid in $(cat ./$cid.txt); do
      echo "$name $cid" > $vid.txt
    done 
  fi
done

rm -f ./404:.json ./.json