#!/usr/bin/env bash

OUT1="{"
TOTAL1=0
for i in 0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z; do
  curl -L https://raw.githubusercontent.com/FETVGuide/livestreams/main/$i.txt -o /tmp/$i.txt
  TOTAL2=0
  OUT2="["
  IFS=$(echo -en "\n\b")
  for entry in $(cat /tmp/$i.txt); do
    if [ "$entry" != "" ]; then
      echo $entry
      name="$(echo "$entry" | awk '{print $1}')"
      cid="$(echo "$entry" | awk '{print $2}')"
      if [ -f "./$cid.txt" ]; then
        COUNT2=$(wc -l ./$cid.txt | awk '{print $1}')
        DATA2="{\"username\": \"$name\", \"channelId\": \"$cid\", \"count\": \"$COUNT2\"}"
        OUT2="$OUT2$DATA2, "
        echo $COUNT2
        TOTAL2=$(($COUNT2 + $TOTAL2));
      fi
    fi
  done
  echo "$OUT2]" | sed 's|, ]$|]|' > ./$i.json
  OUT1="$OUT1\"$i\": \"$TOTAL2\", "
  TOTAL1=$(($TOTAL2 + $TOTAL1));
done
echo "$OUT1}" | sed 's|, }$|}|' > ./total.json
echo $TOTAL1 > total.txt
git add -A
git commit -m "update videos count"
git pull --rebase
git push || true