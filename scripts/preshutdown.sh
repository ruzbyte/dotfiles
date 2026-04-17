!#/bin/sh

TIMEOUT=5

WINE_PROCS=$(pgrep -f '(wine|wineserver|winedevice|wine-preloader|wine64-preloader|\.exe)' 2>/dev/null)

if [ -z "$WINE_PROCS" ]; then
    echo "No Wine-Processes identified"
    exit 0
fi


echo "Cleaning up potentially blocking wine processes, trying gracefully"

wineserver -k 2>/dev/null

for pid in $WINE_PROCS; do
    if kill -0 "$pid" 2>/dev/null; then
	kill -TERM "$pid" 2>/dev/null
    fi
done

sleep "$TIMEOUT"
 
REMAINING=$(pgrep -f '(wine|wineserver|winedevice|wine-preloader|wine64-preloader|\.exe)' 2>/dev/null)
 
if [ -n "$REMAINING" ]; then
    echo "wine processes not reacting, force killing..."
    for pid in $REMAINING; do
        kill -9 "$pid" 2>/dev/null
    done
fi
 
echo "all wine processes cleared"
exit 0
