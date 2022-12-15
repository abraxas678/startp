#!/bin/bash
#echo $1
if [[ $1 = *"xia"* ]]
then
  echo open on xiaomi

  curl https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?apikey=304c57b5ddbd4c10b03b76fa97d44559&deviceNames=xiaomi&app=$2
fi

if [[ $1 = "tt" ]]
then
  myurl=$(/usr/bin/task $2 | grep url | sed 's/url//' | sed 's/ //g' | sed 's/.*\/\///')
else
  myurl=$($HOME/bin/urlencode.sh $@)
fi
mycount=${#myurl}
echo $mycount

echo; echo "[open] [tt] [tt-id]"
echo "[open] [url]" 
echo
echo "http://$MY_TS_RAZER_IP/?openme&$myurl"
curl -s "http://$MY_TS_RAZER_IP/?openme&$myurl" >/dev/null

#curl "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?apikey=304c57b5ddbd4c10b03b76fa97d44559&deviceNames=chrome-razer&url=$myurl"


echo myurl $myurl
echo curl "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?apikey=304c57b5ddbd4c10b03b76fa97d44559&deviceNames=sidekick&url=$myurl"
curl "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?apikey=304c57b5ddbd4c10b03b76fa97d44559&deviceNames=sidekick&url=$myurl"
