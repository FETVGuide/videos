#!/usr/bin/env bash

# while true; do ./bin/youtube-video-channels.sh; echo 'waiting 2 hours before run youtube-video-channels.sh';date; sleep 7200; done

for i in 0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z; do
  curl -L https://raw.githubusercontent.com/FETVGuide/livestreams/main/$i.txt -o /tmp/$i.txt
  IFS=$(echo -en "\n\b")
  for entry in $(cat /tmp/$i.txt); do
    if [ "$entry" != "" ]; then
      echo $entry
      name="$(echo "$entry" | awk '{print $1}')"
      cid="$(echo "$entry" | awk '{print $2}')"
cat << EOF > ./$cid.txt
$(yt-dlp --get-id https://www.youtube.com/channel/$cid)
EOF
      for vid in $(cat ./$cid.txt); do
        echo "$name $cid" > $vid.txt
      done
      for i in - _ 0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z; do
        git add $i*;
      done
      git commit -am "update videos - $name";
      git push;
      # sleep 1;
    fi
  done
done
rm -f ./404:.json ./.json
