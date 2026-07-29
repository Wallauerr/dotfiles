#!/bin/bash

DATA=$(curl -s "wttr.in/?format=j1" 2>/dev/null)

if [ -z "$DATA" ]; then
    echo '{"text": "", "class": "unavailable"}'
    exit 0
fi

TEMP=$(echo "$DATA" | jq -r '.current_condition[0].temp_C')
CODE=$(echo "$DATA" | jq -r '.current_condition[0].weatherCode')
DESC=$(echo "$DATA" | jq -r '.current_condition[0].weatherDesc[0].value')

case "$CODE" in
    113) ICON="☀️" ;;
    116) ICON="⛅" ;;
    119|122) ICON="☁️" ;;
    143|248|260) ICON="🌫️" ;;
    176|263|266|293|296|299|302|305|308|353|356|359) ICON="🌧️" ;;
    179|182|185|227|230|311|314|317|320|323|326|329|332|335|338|350|362|365|368|371|374|377|395) ICON="❄️" ;;
    200|386|389|392) ICON="⛈️" ;;
    281|284) ICON="🌧️" ;;
    *) ICON="☀️" ;;
esac

echo "{\"text\": \"$ICON $TEMP°C\", \"tooltip\": \"$DESC\"}"
